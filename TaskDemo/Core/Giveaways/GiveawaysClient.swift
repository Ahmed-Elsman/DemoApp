//
//  GiveawaysClient.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import ComposableArchitecture
import Foundation

protocol GiveawaysClientProtocol {
    var fetch: (Platform?) async throws -> [Giveaway] { get }
}

struct GiveawaysClient: GiveawaysClientProtocol {
    static let baseUrl = "https://www.gamerpower.com/api/"
    var fetch: (Platform?) async throws -> [Giveaway]
}

extension GiveawaysClient: DependencyKey {
    static let liveValue: GiveawaysClientProtocol = Self(
        fetch: { platform in
            let urlString: String
            if let platform = platform {
                urlString = "\(baseUrl)giveaways?platform=\(platform.rawValue)"
            } else {
                urlString = "\(baseUrl)giveaways"
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
    var giveaways: GiveawaysClientProtocol {
        get { self[GiveawaysClient.self] }
        set { self[GiveawaysClient.self] = newValue }
    }
}
