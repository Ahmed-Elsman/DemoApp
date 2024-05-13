//
//  GiveawaysClient.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import ComposableArchitecture
import Foundation

struct GiveawaysClient {
    var fetch: () async throws -> [Giveaway]
}

extension GiveawaysClient: DependencyKey {
    static let liveValue = Self(
        fetch: {
            guard let url = URL(string: "https://www.gamerpower.com/api/giveaways") else {
                throw URLError(.badURL)
            }
            // FIXME: need to handle this using alamofire
            let (data, _) = try await URLSession.shared.data(from: url)
            let giveaways = try JSONDecoder().decode([Giveaway].self, from: data)
            return giveaways
        }
    )
}

extension DependencyValues {
    var giveaways: GiveawaysClient {
        get { self[GiveawaysClient.self] }
        set { self[GiveawaysClient.self] = newValue }
    }
}
