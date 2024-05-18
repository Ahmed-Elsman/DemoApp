//
//  GiveawayModel.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import Foundation

struct Giveaway: Codable, Equatable, Identifiable {
    let id: Int
    let title, worth: String
    let thumbnail, image: String
    let description, instructions: String
    let openGiveawayURL: String
    let publishedDate, type, platforms, endDate: String
    let users: Int
    let status: String
    let gamerpowerURL, openGiveaway: String

    enum CodingKeys: String, CodingKey {
        case id, title, worth, thumbnail, image, description, instructions
        case openGiveawayURL = "open_giveaway_url"
        case publishedDate = "published_date"
        case type, platforms
        case endDate = "end_date"
        case users, status
        case gamerpowerURL = "gamerpower_url"
        case openGiveaway = "open_giveaway"
    }
}

extension Giveaway {
    static let mock: Giveaway = Giveaway(
        id: 128,
        title: "random",
        worth: "ranndom",
        thumbnail: "",
        image: "",
        description: "random",
        instructions: "ranndom",
        openGiveawayURL: "",
        publishedDate: "",
        type: "",
        platforms: "",
        endDate: "",
        users: 5,
        status: "",
        gamerpowerURL: "",
        openGiveaway: ""
    )
    
    static let mockedArray: [Giveaway] = [
        Giveaway(
            id: 128,
            title: "random",
            worth: "ranndom",
            thumbnail: "",
            image: "",
            description: "random",
            instructions: "ranndom",
            openGiveawayURL: "",
            publishedDate: "",
            type: "",
            platforms: "",
            endDate: "",
            users: 5,
            status: "",
            gamerpowerURL: "",
            openGiveaway: ""
        ),
        Giveaway(
            id: 129,
            title: "random",
            worth: "ranndom",
            thumbnail: "",
            image: "",
            description: "random",
            instructions: "ranndom",
            openGiveawayURL: "",
            publishedDate: "",
            type: "",
            platforms: "",
            endDate: "",
            users: 5,
            status: "",
            gamerpowerURL: "",
            openGiveaway: ""
        )
    ]
}
