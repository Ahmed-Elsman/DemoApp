//
//  GiveawayDetailsFeatureTests.swift
//  TaskDemoTests
//
//  Created by Ahmed Elsman on 18/05/2024.
//

import XCTest
import ComposableArchitecture
@testable import TaskDemo
import SwiftUI

@MainActor
final class GiveawayDetailsFeatureTests: XCTestCase {

    // Test setting giveaway details
    func testSetGiveawayDetails() async {
        let initialGiveaway = Giveaway.mock
        let newGiveaway = Giveaway(
            id: 1,
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
            users: 50,
            status: "",
            gamerpowerURL: "",
            openGiveaway: ""
        )
        
        let store = TestStore(
            initialState: GiveawayDetailsFeature.State(giveaway: initialGiveaway)
        ) {
            GiveawayDetailsFeature()
        }
        
        await store.send(.setGiveawayDetails(newGiveaway)) {
            $0.giveaway = newGiveaway
        }
    }
    
    // Test setting giveaway image
    func testSetGiveawayImage() async {
        let store = TestStore(
            initialState: GiveawayDetailsFeature.State(giveaway: Giveaway.mock)
        ) {
            GiveawayDetailsFeature()
        }
        
        let imageUrl = "https://picsum.photos/600/600"
        
        await store.send(.setGiveawayImage(imageUrl))
        
        await store.receive(\.imageLoaderAction) {
            $0.imageLoaderState.imageUrlString = imageUrl
        }
    }
    
    // Test setting giveaway image content mode
    func testSetGiveawayImageContentMode() async {
        let store = TestStore(
            initialState: GiveawayDetailsFeature.State(giveaway: Giveaway.mock)
        ) {
            GiveawayDetailsFeature()
        }
        
        let contentMode: ContentMode = .fill
        
        await store.send(.setGiveawayImageContentMode(contentMode))
        
        await store.receive(\.imageLoaderAction) {
            $0.imageLoaderState.contentMode = contentMode
        }
    }
}
