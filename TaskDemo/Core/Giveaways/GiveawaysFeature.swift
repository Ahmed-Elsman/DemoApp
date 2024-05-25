//
//  GiveawaysFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct GiveawaysFeature {
    
    @ObservableState
    struct State: Equatable {
        var currentUser: User?
        var imageLoaderState = ImageLoaderFeature.State()
    }
    
    enum Action {
        case imageLoaderAction(ImageLoaderFeature.Action)
        case setCurrentUser(User)
        case setUserImage(String)
        case setUserImageContentMode(ContentMode)
    }
    
    var body: some Reducer<State, Action> {
        
        Scope(state: \.imageLoaderState, action: \.imageLoaderAction) {
            ImageLoaderFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .setCurrentUser(user):
                state.currentUser = user
                return .run { send in
                    await send(.setUserImage(user.imageUrl))
                }
            case let .setUserImage(userImage):
                return .run { send in
                    await send(.imageLoaderAction(.setImageUrlString(userImage)))
                }
            case let .setUserImageContentMode(contentMode):
                return .run { send in
                    await send(.imageLoaderAction(.setContentMode(contentMode)))
                }
            case .imageLoaderAction:
                return .none
            }
        }
    }
}
