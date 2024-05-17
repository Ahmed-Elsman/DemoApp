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
        var giveaway: String?
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            }
            return .none
        }
    }
}
