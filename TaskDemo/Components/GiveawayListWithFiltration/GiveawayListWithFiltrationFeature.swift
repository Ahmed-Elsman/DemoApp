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
    }
    enum Action {
        case filterList(PlatformFilterListFeature.Action)
        case giveawayVlist(GiveawayVListFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.filterList, action: \.filterList) {
            PlatformFilterListFeature()
        }
        Scope(state: \.giveawayVlist, action: \.giveawayVlist) {
            GiveawayVListFeature()
        }
        
        Reduce { state, action in
            // Core logic of the composed feature
            return .none
        }
    }
}
