//
//  GiveawayListFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 15/05/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct GiveawayCarouslFeature {
    
    struct State: Equatable {
        var giveaways: [Giveaway]?
        var giveawaysStatesList: IdentifiedArrayOf<GiveawayCellFeature.State> = []
        var isloading = false
        var giveawayVListState = GiveawayVListFeature.State()
    }
    
    enum Action {
        case getGiveaways
        case giveawaysResponse(Result<[Giveaway]?, Error>)
        case giveawayCellAction(GiveawayCellFeature.State.ID, GiveawayCellFeature.Action)
        case giveawayVListAction(GiveawayVListFeature.Action)
        case setAllGiveawaysForFiltration([Giveaway])
    }
    
    @Dependency (\.giveaways) var giveaways
    
    var body: some Reducer<State, Action> {
        
        Scope(state: \.giveawayVListState, action: \.giveawayVListAction) {
            GiveawayVListFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .getGiveaways:
                state.giveaways = nil
                state.isloading = true
                return .run { send in
                    let data = try await giveaways.fetch(nil)
                    await send(.giveawaysResponse(.success(data)))
                }
            case let .giveawaysResponse(result):
                state.isloading = false
                switch result {
                case let .success(giveaways):
                    state.giveaways = giveaways
                    state.giveawaysStatesList = IdentifiedArray(uniqueElements: giveaways?.map { giveaway in
                        GiveawayCellFeature.State(id: UUID(),imageName: giveaway.image, title: giveaway.title, description: giveaway.description, selectedGiveaway: giveaway, isCarousel: true)
                    } ?? [])
                    return .run { send in
                        if let allGiveaways = giveaways {
                            await send(.setAllGiveawaysForFiltration(allGiveaways))
                        }
                    }
                case .failure(_):
                    // FIXME: need to handle error messages
                    state.giveaways = []
                    state.giveawaysStatesList = []
                    return .none
                }
                
            case let .setAllGiveawaysForFiltration(allGiveaways):
                return .run { send in
                    await send(.giveawayVListAction(.setAllGiveaways(allGiveaways)))
                }
            case .giveawayVListAction:
                return .none
            case .giveawayCellAction:
                return .none
            }
        }
        .forEach(\.giveawaysStatesList, action: /Action.giveawayCellAction) {
            GiveawayCellFeature()
        }
    }
}
