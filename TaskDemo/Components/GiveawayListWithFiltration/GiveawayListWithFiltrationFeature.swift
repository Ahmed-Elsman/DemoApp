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
    }
    enum Action {
        case filterList(PlatformFilterListFeature.Action)
        case giveawayVlist(GiveawayVListFeature.Action)
        case setSelectedPlatform(Platform)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.filterList, action: \.filterList) {
            PlatformFilterListFeature()
        }
        Scope(state: \.giveawayVlist, action: \.giveawayVlist) {
            GiveawayVListFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .filterList(.selectPlatform(platform)):
                return .run { send in
                    await send(.setSelectedPlatform(platform))
                }
            case let .setSelectedPlatform(platform):
                if state.selectedPlatform != platform {
                    state.selectedPlatform = platform
                    return .run { send in
                        await send(.giveawayVlist(.getFilteredGiveaways(platform)))
                    }
                } else {
                    return .none
                }
            case .giveawayVlist:
                return .none
            case .filterList:
                return .none
            }
        }
    }
}
