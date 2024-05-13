//
//  GiveawaysFeature.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import ComposableArchitecture

@Reducer
struct GiveawaysFeature {
    
    @ObservableState
    struct State: Equatable {
        var giveaways: [Giveaway]?
        var isloading = false
    }
    
    enum Action {
        case getGiveaways
        case giveawaysResponse(Result<[Giveaway]?, Error>)
    }
    
    @Dependency (\.giveaways) var giveaways
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .getGiveaways:
                state.giveaways = nil
                state.isloading = true
                return .run { send in
                    let data = try await giveaways.fetch()
                    await send(.giveawaysResponse(.success(data)))
                }
            case let .giveawaysResponse(result):
                state.isloading = false
                switch result {
                case let .success(giveaways):
                    state.giveaways = giveaways
                    return .none
                case .failure(_):
                    // FIXME: need to handle error messages
                    state.giveaways = []
                    return .none
                }
            }
        }
    }
}
