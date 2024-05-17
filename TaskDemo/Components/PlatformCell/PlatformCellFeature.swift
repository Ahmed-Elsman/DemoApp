//
//  PlatformCellFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 14/05/2024.
//

import ComposableArchitecture
import Foundation
@Reducer
struct PlatformCellFeature {
    
    
    struct State: Equatable, Identifiable {
        let id: UUID
        var title: String
        var isSelected: Bool
        var platform: Platform
        
        init(id: UUID, title: String, isSelected: Bool, platform: Platform) {
            self.id = id
            self.title = title
            self.isSelected = isSelected
            self.platform = platform
        }
    }
    
    enum Action {
        case selectPlatfrom(Platform)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .selectPlatfrom(platform):
                state.isSelected = true
                state.platform = platform
                return .none
            }
        }
    }
}
