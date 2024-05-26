//
//  ImageLoaderFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 14/05/2024.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct ImageLoaderFeature {

    struct State: Equatable {
        var imageUrl: String?
        var contentMode: ContentMode?
    }

    enum Action {
        case setImageUrl(String)
        case setContentMode(ContentMode)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .setImageUrl(image):
                state.imageUrl = image
                return .none

            case let .setContentMode(contentMode):
                state.contentMode = contentMode
                return .none
            }
        }
    }
}
