//
//  GiveawayVListFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct GiveawayVListFeature {
    
    typealias IdentifiedGiveawayCellStates = IdentifiedArrayOf<GiveawayCellFeature.State>
    
    struct State: Equatable {
        var filteredGiveaways: [Giveaway]?
        var allGiveaways: [Giveaway]?
        var filteredGiveawaysStatesList: IdentifiedGiveawayCellStates = []
        var allGiveawaysStatesList: IdentifiedGiveawayCellStates = []
        var isLoading = false
        var cellSize: CGFloat = 350
        var selectedPlatform: Platform = .all
    }
    
    enum Action {
        case getFilteredGiveawaysList(frameWidth: CGFloat, platform: Platform)
        case giveawaysResponse(Result<[Giveaway]?, Error>)
        case giveawayCellAction(IdentifiedActionOf<GiveawayCellFeature>)
        case setCellSize(CGFloat)
        case setSelectedPlatform(CGFloat, Platform)
        case getFilteredGiveaways(Platform)
        case setAllGiveaways([Giveaway])
    }
    
    @Dependency (\.giveaways) var giveaways
    
    var body: some Reducer<State, Action> {
        
        Reduce {state, action in
            switch action {
            case let .setAllGiveaways(allGiveaways):
                state.allGiveaways = allGiveaways
                state.allGiveawaysStatesList = mapGiveaways(giveaways: allGiveaways, cellSize: state.cellSize)
                let frameWidth = state.cellSize
                return .run { send in
                    await send(.setCellSize(frameWidth))
                    await send(.getFilteredGiveawaysList(frameWidth: frameWidth, platform: Platform.all))
                }
                
            case let .getFilteredGiveaways(platform):
                let frameWidth = state.cellSize
                return .run { send in
                    await send(.setSelectedPlatform(frameWidth, platform))
                }
                
            case let .setSelectedPlatform(frameWidth, platform):
                state.selectedPlatform = platform
                return .run { send in
                    await send(.getFilteredGiveawaysList(frameWidth: frameWidth, platform: platform))
                }
                
            case let .getFilteredGiveawaysList(frameWidth, platform):
                guard platform == .all else {
                    state.filteredGiveaways = nil
                    state.filteredGiveawaysStatesList = []
                    state.isLoading = true
                    return .run { send in
                        let data = try await giveaways.fetch(platform)
                        await send(.setCellSize(frameWidth))
                        await send(.giveawaysResponse(.success(data)))
                    }
                }
                state.filteredGiveaways = state.allGiveaways
                state.filteredGiveawaysStatesList = state.allGiveawaysStatesList
                return .none
                
            case let .giveawaysResponse(result):
                state.isLoading = false
                handleGiveawaysResponse(state: &state,result: result)
                return .none
                
            case .giveawayCellAction:
                return .none
                
            case let .setCellSize(cellSize):
                state.cellSize = cellSize
                return .none
            }
        }
        .forEach(\.filteredGiveawaysStatesList, action: \.giveawayCellAction) {
            GiveawayCellFeature()
        }
    }
    
    private func mapGiveaways(giveaways: [Giveaway], cellSize: CGFloat) -> IdentifiedGiveawayCellStates {
        return IdentifiedArray(uniqueElements: giveaways.map { giveaway in
            GiveawayCellFeature.State(
                id: UUID(),
                imageSize: cellSize,
                imageName: giveaway.image,
                title: giveaway.title,
                description: giveaway.description,
                selectedGiveaway: giveaway,
                isCarousel: false
            )
        })
    }
    
    private func handleGiveawaysResponse(state: inout GiveawayVListFeature.State, result: Result<[Giveaway]?, Error>) {
        switch result {
        case let .success(giveaways):
            state.filteredGiveaways = giveaways
            state.filteredGiveawaysStatesList = mapGiveaways(giveaways: giveaways ?? [], cellSize: state.cellSize)
        case .failure(_):
            // FIXME: need to handle error messages
            state.filteredGiveaways = []
            state.filteredGiveawaysStatesList = []
        }
    }
}
