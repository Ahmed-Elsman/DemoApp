//
//  GiveawaysClient.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import ComposableArchitecture
import Foundation

struct GiveawaysClient {
    var fetch: (Platform?) async throws -> [Giveaway]
}

extension GiveawaysClient: DependencyKey {
    static let liveValue = Self(
        fetch: { platform in
            let urlString: String
            if let platform = platform {
                urlString = "https://www.gamerpower.com/api/giveaways?platform=\(platform.rawValue)"
            } else {
                urlString = "https://www.gamerpower.com/api/giveaways"
            }
            
            guard let url = URL(string: urlString) else {
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
