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
    struct State: Equatable, Identifiable {
        let id: UUID
        var imageSize: CGFloat = 300
        var imageName: String
        var title: String
        var description: String
        var selectedGiveaway: Giveaway
        
        init(id: UUID ,imageSize: CGFloat = 300, imageName: String, title: String, description: String, selectedGiveaway: Giveaway) {
            self.id = id
            self.imageSize = imageSize
            self.imageName = imageName
            self.title = title
            self.description = description
            self.selectedGiveaway = selectedGiveaway
        }
    }
    
    enum Action {
        case giveawayTapped(Giveaway)
    }
    
    var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
            case let .giveawayTapped(giveaway):
                print("\(giveaway.title)")
                state.selectedGiveaway = giveaway
                return .none
            }
        }
    }
}
