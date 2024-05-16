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
    }
    
    enum Action {
        case getGiveawaysList(frameWidth: CGFloat)
        case giveawaysResponse(Result<[Giveaway]?, Error>)
        case giveawayCellAction(GiveawayCellFeature.State.ID, GiveawayCellFeature.Action)
        case setCellSize(CGFloat)
    }
    
    @Dependency (\.giveaways) var giveaways
    
    var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
            case let .getGiveawaysList(frameWidth):
                state.giveaways = nil
                state.isloading = true
                return .run { send in
                    let data = try await giveaways.fetch(Platform.ios)
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
