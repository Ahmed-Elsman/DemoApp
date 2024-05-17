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
    
    
    struct State: Equatable {
        var selectedPlatform: Platform? = Platform(rawValue: "all")
        var platformStatesList: IdentifiedArrayOf<PlatformCellFeature.State> = []
        var platforms = Platform.allCases
    }
    
    enum Action {
        case platformCellAction(PlatformCellFeature.State.ID, PlatformCellFeature.Action)
        case selectPlatform(Platform)
        case setPlatforms
    }
    
    var body: some Reducer<State, Action> {
        
        Reduce { state, action in
            switch action {
            case .setPlatforms:
                state.platformStatesList = IdentifiedArrayOf(uniqueElements: state.platforms.map { platform in
                    PlatformCellFeature.State(id: UUID(), title: platform.rawValue, isSelected: platform == state.selectedPlatform ? true : false, platform: platform)
                })
                return .none
  
            case let .platformCellAction(_, platformAction):
                switch platformAction {
                case let .selectPlatfrom(platform):
                    return .run { send in
                        await send(.selectPlatform(platform))
                    }
                }
                
            case let .selectPlatform(platform):
                state.selectedPlatform = platform
                state.platformStatesList = IdentifiedArrayOf(uniqueElements: state.platformStatesList.map { platformState in
                    PlatformCellFeature.State(
                        id: platformState.id,
                        title: platformState.title,
                        isSelected: platformState.platform == platform,
                        platform: platformState.platform
                    )
                })
                return .none
            }
            
        }
        .forEach(\.platformStatesList, action: /Action.platformCellAction) {
            PlatformCellFeature()
        }
    }
}





