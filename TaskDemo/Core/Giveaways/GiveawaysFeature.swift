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
    }
    
    enum Action {
        case imageLoaderState(ImageLoaderFeature.Action)
    }
    
    var body: some Reducer<State, Action> {
        
        Scope(state: \.imageLoaderState, action: \.imageLoaderState) {
            ImageLoaderFeature()
        }
        
        Reduce { state, action in
           return .none
        }
    }
}
