//
//  PlatformFilterListFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import ComposableArchitecture
import Foundation

@Reducer
struct PlatformFilterListFeature {

    typealias IdentifiedPlatformCellStates = IdentifiedArrayOf<PlatformCellFeature.State>

    struct State: Equatable {
        var selectedPlatform: Platform? = .all
        var platformStatesList: IdentifiedPlatformCellStates = []
        var platforms = Platform.allCases
    }

    enum Action {
        case platformCellAction(IdentifiedActionOf<PlatformCellFeature>)
        case selectPlatform(Platform)
        case setPlatforms
    }

    var body: some Reducer<State, Action> {

        Reduce { state, action in
            switch action {
            case .setPlatforms:
                state.platformStatesList = mapPlatforms(state: &state)
                return .none

            case let .platformCellAction(platformAction):
                return handlePlatformCellAction(platformAction, state: &state)

            case let .selectPlatform(platform):
                state.selectedPlatform = platform
                return .run { send in
                    await send(.setPlatforms)
                }
            }
        }
        .forEach(\.platformStatesList, action: \.platformCellAction) {
            PlatformCellFeature()
        }
    }

    private func mapPlatforms(state: inout State) -> IdentifiedPlatformCellStates {
        return IdentifiedArrayOf(uniqueElements: state.platforms.map { platform in
            PlatformCellFeature.State(
                id: UUID(),
                title: platform.rawValue,
                isSelected: platform == state.selectedPlatform ? true : false,
                platform: platform
            )
        })
    }

    private func handlePlatformCellAction(_ platformAction: IdentifiedActionOf<PlatformCellFeature>, state: inout State) -> Effect<Action> {
        guard case let .element(_, action: action) = platformAction else {
            return .none
        }

        switch action {
        case let .selectPlatform(platform):
            return .run { send in
                await send(.selectPlatform(platform))
            }
        }
    }
}
