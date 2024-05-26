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
        var giveawayCarousel = GiveawayCarouselFeature.State()
        var giveawayListWithFilter = GiveawayListWithFiltrationFeature.State()
        var allGiveaways: [Giveaway]?
    }
    enum Action {
        case giveawayAction(GiveawaysFeature.Action)
        case giveawayCarouselAction(GiveawayCarouselFeature.Action)
        case giveawayListWithFilterAction(GiveawayListWithFiltrationFeature.Action)
    }

    var body: some ReducerOf<Self> {

        Scope(state: \.giveaway, action: \.giveawayAction) {
            GiveawaysFeature()
        }

        Scope(state: \.giveawayCarousel, action: \.giveawayCarouselAction) {
            GiveawayCarouselFeature()
        }

        Scope(state: \.giveawayListWithFilter, action: \.giveawayListWithFilterAction) {
            GiveawayListWithFiltrationFeature()
        }

        Reduce { state, action in
            switch action {
            case let .giveawayCarouselAction(.setAllGiveawaysForFiltration(giveaways)):
                state.allGiveaways = giveaways
                return .run { send in
                    await send(.giveawayListWithFilterAction(.setAllGiveaways(giveaways)))
                }
            case .giveawayCarouselAction:
                return .none
            case .giveawayAction:
                return .none
            case .giveawayListWithFilterAction:
                return .none
            }
        }
    }
}
