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
    @ObservableState
    struct State: Equatable {
        var imageUrlString: String = Constants.randomImage
        var contentMode: ContentMode = .fill
    }
    
    enum Action {
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
    }
}
