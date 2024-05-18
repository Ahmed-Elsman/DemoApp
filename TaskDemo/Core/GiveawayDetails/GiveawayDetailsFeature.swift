//
//  GiveawayDetailsFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 15/05/2024.
//


import ComposableArchitecture
import SwiftUI

@Reducer
struct GiveawayDetailsFeature {
    
    struct State: Equatable {
        var giveaway: Giveaway?
    }
    
    enum Action {
        case setGiveawayDetails(Giveaway)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .setGiveawayDetails(giveaway):
                state.giveaway = giveaway
                return .none
            }
        }
    }
}
