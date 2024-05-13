//
//  UserModel.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import Foundation

struct User: Codable, Equatable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let image: String

    
    static var mock: User {
        User(
            id: 111,
            firstName: "Ahmed",
            lastName: "Elsman",
            image: Constants.randomImage
        )
    }
}
