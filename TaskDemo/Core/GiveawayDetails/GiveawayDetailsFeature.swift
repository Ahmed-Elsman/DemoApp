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
        var giveaway: Giveaway
        var imageLoaderState = ImageLoaderFeature.State()
    }
    
    enum Action {
        case setGiveawayDetails(Giveaway)
        case imageLoaderAction(ImageLoaderFeature.Action)
        case setGiveawayImage(String)
        case setGiveawayImageContentMode(ContentMode)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.imageLoaderState, action: \.imageLoaderAction) {
            ImageLoaderFeature()
        }
        
        
        Reduce { state, action in
            switch action {
            case let .setGiveawayDetails(giveaway):
                state.giveaway = giveaway
                return .none
            case let .setGiveawayImage(image):
                return .run { send in
                    await send(.imageLoaderAction(.setImageUrlString(image)))
                }
            case let .setGiveawayImageContentMode(contentMode):
                return .run { send in
                    await send(.imageLoaderAction(.setcontentMode(contentMode)))
                }
            case .imageLoaderAction:
                return .none
            }
        }
    }
}
