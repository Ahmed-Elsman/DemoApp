//
//  GiveawayListWithFiltrationFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import ComposableArchitecture

@Reducer
struct GiveawayListWithFiltrationFeature {
    struct State: Equatable {
        var filterList = PlatformFilterListFeature.State()
        var giveawayVList = GiveawayVListFeature.State()
        var selectedPlatform: Platform = Platform.all
    }
    enum Action {
        case filterListAction(PlatformFilterListFeature.Action)
        case giveawayVListAction(GiveawayVListFeature.Action)
        case setSelectedPlatform(Platform)
        case setAllGiveaways([Giveaway])
    }

    var body: some ReducerOf<Self> {

        Scope(state: \.filterList, action: \.filterListAction) {
            PlatformFilterListFeature()
        }
        Scope(state: \.giveawayVList, action: \.giveawayVListAction) {
            GiveawayVListFeature()
        }

        Reduce { state, action in
            switch action {
            case let .setAllGiveaways(allGiveaways):
                return .run { send in
                    await send(.giveawayVListAction(.setAllGiveaways(allGiveaways)))
                }
            case let .filterListAction(.selectPlatform(platform)):
                return .run { send in
                    await send(.setSelectedPlatform(platform))
                }
            case let .setSelectedPlatform(platform) where state.selectedPlatform != platform:
                state.selectedPlatform = platform
                return .run { send in
                    await send(.giveawayVListAction(.getFilteredGiveaways(platform)))
                }
            case .setSelectedPlatform:
                return .none
            case .giveawayVListAction:
                return .none
            case .filterListAction:
                return .none
            }
        }
    }
}
