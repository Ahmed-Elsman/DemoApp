//
//  PlatformCellFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 14/05/2024.
//

import ComposableArchitecture

@Reducer
struct PlatformCellFeature {
    
    @ObservableState
    struct State: Equatable {
        var title: String
        var isSelected: Bool
        
        init(title: String, isSelected: Bool) {
            self.title = title
            self.isSelected = isSelected
        }
    }
    
    enum Action {
        case toggleSelection
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .toggleSelection:
                state.isSelected.toggle()
                return .none
            }
        }
    }
}
