//
//  UserModel.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import Foundation

struct User: Codable, Equatable, Identifiable {
    let id: Int
    let name: String
    let imageUrl: String

    static var mock: User {
        User(
            id: 111,
            name: "Ahmed",
            imageUrl: "https://picsum.photos/600/600"
        )
    }
}
