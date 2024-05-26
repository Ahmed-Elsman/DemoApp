//
//  GiveawayCellFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 14/05/2024.
//

import SwiftUI
import ComposableArchitecture


@Reducer
struct GiveawayCellFeature {
    
    struct State: Equatable, Identifiable {
        let id: UUID
        var imageSize: CGFloat = 300
        var imageUrl: String
        var title: String
        var description: String
        var selectedGiveaway: Giveaway
        var isCarousel: Bool = true
        var imageLoaderState = ImageLoaderFeature.State()
        var navigateToDetails: Bool = false
    }
    
    enum Action {
        case giveawayTapped(Giveaway)
        case imageLoaderAction(ImageLoaderFeature.Action)
        case setGiveawayImage(String)
        case setGiveawayImageContentMode(ContentMode)
        case navigateToDetails(Bool)
    }
    
    var body: some Reducer<State, Action> {
        
        Scope(state: \.imageLoaderState, action: \.imageLoaderAction) {
            ImageLoaderFeature()
        }
        
        Reduce { state, action in
            switch action {
            case let .giveawayTapped(giveaway):
                state.selectedGiveaway = giveaway
                state.navigateToDetails = true
                return .none
            case let .setGiveawayImage(image):
                return .run { send in
                    await send(.imageLoaderAction(.setImageUrl(image)))
                }
            case let .setGiveawayImageContentMode(contentMode):
                return .run { send in
                    await send(.imageLoaderAction(.setContentMode(contentMode)))
                }
            case .imageLoaderAction:
                return .none
            case let .navigateToDetails(navigate):
                state.navigateToDetails = navigate
                return .none
            }
        }
    }
}
