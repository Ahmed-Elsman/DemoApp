//
//  GiveawaysFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct GiveawaysFeature {
    
    @ObservableState
    struct State: Equatable {
        var currentUser: User = User.mock
        var imageLoaderState = ImageLoaderFeature.State()
//        var platformCellState: PlatformCellFeature.State = PlatformCellFeature.State(title: "aaa", isSelected: false)
//        var selectedPlatform: Platform? = Platform(rawValue: "all")
    }
    
    enum Action {
        case imageLoaderState(ImageLoaderFeature.Action)
//        case platformCellAction(PlatformCellFeature.Action)
//        case selectPlatform(Platform)
    }
    
    @Dependency (\.giveaways) var giveaways
    
    var body: some Reducer<State, Action> {
        
        Scope(state: \.imageLoaderState, action: \.imageLoaderState) {
            ImageLoaderFeature()
        }
        
//        Scope(state: \.platformCellState, action: \.platformCellAction) {
//            PlatformCellFeature()
//        }
        
        Reduce { state, action in
            switch action {
                
            case .imageLoaderState:
                return .none
                
//            case let .selectPlatform(platform):
//                state.selectedPlatform = platform
//                return .none
//            case let .platformCellAction(action):
//                switch action {
//                case let .selectPlatfrom(platform):
//                    state.selectedPlatform = platform
//                    return .none
//                }
            }
        }
    }
}
