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
    @ObservableState
    struct State: Equatable {
        var imageSize: CGFloat
        var imageName: String
        var title: String
        var description: String
        
        init(imageSize: CGFloat = 300, imageName: String, title: String, description: String) {
            self.imageSize = imageSize
            self.imageName = imageName
            self.title = title
            self.description = description
        }
    }
    
    enum Action {
        case loadImage
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadImage:
                return .none
            }
        }
    }
}
