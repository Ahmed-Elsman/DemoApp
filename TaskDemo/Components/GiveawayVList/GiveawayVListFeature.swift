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
    @ObservableState
    struct State: Equatable {
        var giveaways: [Giveaway]?
        var giveawaysStatesList: IdentifiedArrayOf<GiveawayCellFeature.State> = []
        var isloading = false
        var cellSize: CGFloat = 300
        var selectedPlatform: Platform = Platform.ios
        var frameWidth: CGFloat = 350
    }
    
    enum Action {
        case getGiveawaysList(frameWidth: CGFloat, platform: Platform)
        case giveawaysResponse(Result<[Giveaway]?, Error>)
        case giveawayCellAction(GiveawayCellFeature.State.ID, GiveawayCellFeature.Action)
        case setCellSize(CGFloat)
        case setSelectedPlatform(CGFloat, Platform)
        case getFilteredGiveaways(Platform)
        case setFramWidth(CGFloat)
    }
    
    @Dependency (\.giveaways) var giveaways
    
    var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
            case let .setFramWidth(frameWidth):
                state.frameWidth = frameWidth
                return .none
            case let .getFilteredGiveaways(platform):
                let frameWidth = state.frameWidth
                return .run { send in
                    await send(.setSelectedPlatform(frameWidth, platform))
                }
            case let .setSelectedPlatform(frameWidth, platform):
                state.selectedPlatform = platform
                return .run { send in
                    await send(.setFramWidth(frameWidth))
                    await send(.getGiveawaysList(frameWidth: frameWidth, platform: platform))
                }
            case let .getGiveawaysList(frameWidth, platform):
                state.giveaways = nil
                state.giveawaysStatesList = []
                state.isloading = true
                return .run { send in
                    let data = try await giveaways.fetch(platform)
                    await send(.setCellSize(frameWidth))
                    await send(.giveawaysResponse(.success(data)))
                }
            case let .giveawaysResponse(result):
                state.isloading = false
                switch result {
                case let .success(giveaways):
                    state.giveaways = giveaways
                    state.giveawaysStatesList = IdentifiedArray(uniqueElements: giveaways?.map { giveaway in
                        GiveawayCellFeature.State(id: UUID(),imageSize: state.cellSize,imageName: giveaway.image, title: giveaway.title, description: giveaway.description, selectedGiveaway: giveaway, isCarousel: false)
                    } ?? [])
                    return .none
                case .failure(_):
                    // FIXME: need to handle error messages
                    state.giveaways = []
                    state.giveawaysStatesList = []
                    return .none
                }
            case .giveawayCellAction:
                return .none
            case let .setCellSize(cellSize):
                state.cellSize = cellSize
                return .none
            }
        }
        .forEach(\.giveawaysStatesList, action: /Action.giveawayCellAction) {
            GiveawayCellFeature()
        }
    }
}
