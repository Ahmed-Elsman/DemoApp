//
//  GiveawaysFeatureTests.swift
//  TaskDemoTests
//
//  Created by Ahmed Elsman on 18/05/2024.
//

import XCTest
import ComposableArchitecture
@testable import TaskDemo

@MainActor
final class GiveawaysFeatureTests: XCTestCase {

    // Test setting the current user
    func testSetCurrentUser() async {
        let store = TestStore(
            initialState: GiveawaysFeature.State()) {
                GiveawaysFeature()
            }
        
        await store.send(.setCurrentUser(User.mock)) {
            $0.currentUser = User.mock
        }
        
        await store.receive(\.setUserImage)
        
        store.exhaustivity = .off
    }
    
    // Test setting user image
    func testSetUserImage() async {
        let store = TestStore(
            initialState: GiveawaysFeature.State()) {
                GiveawaysFeature()
            }
        
        await store.send(.setUserImage(User.mock.imageUrl))
        
        await store.receive(\.imageLoaderAction) {
            // Verify the imageLoaderAction was sent
            $0.imageLoaderState.imageUrlString = User.mock.imageUrl
        }
    }
    
    // Test setting user image content mode
    func testSetUserImageContentMode() async {
        let store = TestStore(
            initialState: GiveawaysFeature.State()) {
                GiveawaysFeature()
            }
        
        store.exhaustivity = .off
        
        await store.send(.setUserImageContentMode(.fill))
        
        await store.receive(\.imageLoaderAction)
    }
}

