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
        var giveawayhome = GiveawaysFeature.State()
        var giveawaylist = GiveawayListFeature.State()
        var giveawayListWithFilter = GiveawayListWithFiltrationFeature.State()
    }
    enum Action {
        case giveawayhome(GiveawaysFeature.Action)
        case giveawaylist(GiveawayListFeature.Action)
        case giveawayListWithFilter(GiveawayListWithFiltrationFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.giveawayhome, action: \.giveawayhome) {
            GiveawaysFeature()
        }
        
        Scope(state: \.giveawaylist, action: \.giveawaylist) {
            GiveawayListFeature()
        }

        Scope(state: \.giveawayListWithFilter, action: \.giveawayListWithFilter) {
            GiveawayListWithFiltrationFeature()
        }
        
        Reduce { state, action in
            // Core logic of the composed feature
            return .none
        }
    }
}

