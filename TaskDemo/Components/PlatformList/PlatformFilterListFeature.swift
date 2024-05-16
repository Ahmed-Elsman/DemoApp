//
//  PlatformFliterListFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct PlatformFilterListFeature {
    
    @ObservableState
    struct State: Equatable {
        var platformCellState: PlatformCellFeature.State = PlatformCellFeature.State(title: "aaa", isSelected: false)
        var selectedPlatform: Platform? = Platform(rawValue: "all")
    }
    
    enum Action {
        case platformCellAction(PlatformCellFeature.Action)
        case selectPlatform(Platform)
    }
    
    var body: some Reducer<State, Action> {
        
        Scope(state: \.platformCellState, action: \.platformCellAction) {
            PlatformCellFeature()
        }
        
        Reduce { state, action in
            switch action {
                
            case let .selectPlatform(platform):
                state.selectedPlatform = platform
                return .none
            case let .platformCellAction(action):
                switch action {
                case let .selectPlatfrom(platform):
                    state.selectedPlatform = platform
                    return .none
                }
            }
        }
    }
}
