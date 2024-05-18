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
        var giveawayVlist = GiveawayVListFeature.State()
        var selectedPlatform: Platform = Platform.all
        var allGiveaways: [Giveaway]?
    }
    enum Action {
        case filterListAction(PlatformFilterListFeature.Action)
        case giveawayVlistAction(GiveawayVListFeature.Action)
        case setSelectedPlatform(Platform)
        case setAllGiveaways([Giveaway])
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.filterList, action: \.filterListAction) {
            PlatformFilterListFeature()
        }
        Scope(state: \.giveawayVlist, action: \.giveawayVlistAction) {
            GiveawayVListFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .setAllGiveaways(allGiveaways):
                state.allGiveaways = allGiveaways
                return .run { send in
                    await send(.giveawayVlistAction(.setAllGiveaways(allGiveaways)))
                }
            case let .filterListAction(.selectPlatform(platform)):
                return .run { send in
                    await send(.setSelectedPlatform(platform))
                }
            case let .setSelectedPlatform(platform):
                if state.selectedPlatform != platform {
                    state.selectedPlatform = platform
                    return .run { send in
                        await send(.giveawayVlistAction(.getFilteredGiveaways(platform)))
                    }
                } else {
                    return .none
                }
            case .giveawayVlistAction:
                return .none
            case .filterListAction:
                return .none
            }
        }
    }
}
