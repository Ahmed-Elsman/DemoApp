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
    }

    enum Action {
        case selectPlatform(Platform)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case let .selectPlatform(platform):
                state.isSelected = true
                state.platform = platform
                return .none
            }
        }
    }
}
