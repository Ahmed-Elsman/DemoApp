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
        var imageUrlString: String?
        var contentMode: ContentMode?
    }
    
    enum Action {
        case setImageUrlString(String)
        case setcontentMode(ContentMode)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .setImageUrlString(image):
                state.imageUrlString = image
                return .none
                
            case let .setcontentMode(contentMode):
                state.contentMode = contentMode
                return .none
            }
        }
    }
}
