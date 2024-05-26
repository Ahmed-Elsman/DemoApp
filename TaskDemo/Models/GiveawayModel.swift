//
//  GiveawayModel.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import Foundation

struct Giveaway: Decodable, Equatable, Identifiable {
    let id: Int
    let title, worth: String
    let image: String
    let description: String
    let type, platforms, endDate: String
    let users: Int

    enum CodingKeys: String, CodingKey {
        case id, title, worth, image, description
        case type, platforms
        case endDate = "end_date"
        case users
    }
}

extension Giveaway {
    static let mock: Giveaway = Giveaway(
        id: 128,
        title: "random title",
        worth: "random worth",
        image: "",
        description: "random description",
        type: "N/A",
        platforms: "ios",
        endDate: "",
        users: 5
    )

    static let mockedArray: [Giveaway] = [
        Giveaway(
            id: 128,
            title: "random title",
            worth: "random worth",
            image: "",
            description: "random description",
            type: "N/A",
            platforms: "ios",
            endDate: "",
            users: 5
        ),
        Giveaway(
            id: 129,
            title: "random title",
            worth: "random worth",
            image: "",
            description: "random description",
            type: "N/A",
            platforms: "ios",
            endDate: "",
            users: 5
        )
    ]
}
