//
//  UserModel.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import Foundation

struct User: Equatable {
    let name: String
    let imageUrl: String

    static var mock: User {
        User(
            name: "Ahmed",
            imageUrl: "https://picsum.photos/600/600"
        )
    }
}
