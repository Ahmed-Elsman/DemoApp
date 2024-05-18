//
//  ComposedFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 15/05/2024.
//

import ComposableArchitecture


@Reducer
struct ComposedFeature {
    struct State: Equatable {
        var giveaway = GiveawaysFeature.State()
        var giveawayCarousl = GiveawayCarouslFeature.State()
        var giveawayListWithFilter = GiveawayListWithFiltrationFeature.State()
        var allGiveaways: [Giveaway]?
    }
    enum Action {
        case giveawayAction(GiveawaysFeature.Action)
        case giveawayCarouslAction(GiveawayCarouslFeature.Action)
        case giveawayListWithFilterAction(GiveawayListWithFiltrationFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.giveaway, action: \.giveawayAction) {
            GiveawaysFeature()
        }
        
        Scope(state: \.giveawayCarousl, action: \.giveawayCarouslAction) {
            GiveawayCarouslFeature()
        }

        Scope(state: \.giveawayListWithFilter, action: \.giveawayListWithFilterAction) {
            GiveawayListWithFiltrationFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .giveawayCarouslAction(.setAllGiveawaysForFiltration(giveaways)):
                state.allGiveaways = giveaways
                return .run { send in
                    await send(.giveawayListWithFilterAction(.setAllGiveaways(giveaways)))
                }
            case .giveawayCarouslAction:
                return .none
            case .giveawayAction:
                return .none
            case .giveawayListWithFilterAction:
                return .none
            }
        }
    }
}

