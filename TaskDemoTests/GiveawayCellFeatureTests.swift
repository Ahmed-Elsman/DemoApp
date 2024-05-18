//
//  GiveawayCellFeatureTests.swift
//  TaskDemoTests
//
//  Created by Ahmed Elsman on 18/05/2024.
//

import XCTest
import ComposableArchitecture
@testable import TaskDemo

@MainActor
final class GiveawayCellFeatureTests: XCTestCase {
    
    // Test giveaway tapped action
    func testGiveawayTappedAction() async {
        let store = TestStore(
            initialState: GiveawayCellFeature.State(id: UUID(),
                                                    imageName: "",
                                                    title: "Test Title",
                                                    description: "Test Description",
                                                    selectedGiveaway: Giveaway.mock,
                                                    isCarousel: true)) {
                                                        GiveawayCellFeature()
                                                    }
        
        await store.send(.giveawayTapped(Giveaway.mock)) {
            $0.selectedGiveaway = Giveaway.mock
            $0.navigateToDetails = true
        }
    }
    
    // Test setting giveaway image action
    func testSetGiveawayImageAction() async {
        let store = TestStore(
            initialState: GiveawayCellFeature.State(id: UUID(),
                                                    imageName: "",
                                                    title: "Test Title",
                                                    description: "Test Description",
                                                    selectedGiveaway: Giveaway.mock,
                                                    isCarousel: true)) {
                                                        GiveawayCellFeature()
                                                    }
        
        await store.send(.setGiveawayImage("testImage"))
        
        await store.receive(\.imageLoaderAction) {
            // Verify the imageLoaderAction was sent
            $0.imageLoaderState.imageUrlString = "testImage"
        }
    }
    
    // Test setting giveaway image content mode action
    func testSetGiveawayImageContentModeAction() async {
        let store = TestStore(
            initialState: GiveawayCellFeature.State(id: UUID(),
                                                    imageName: "",
                                                    title: "Test Title",
                                                    description: "Test Description",
                                                    selectedGiveaway: Giveaway.mock,
                                                    isCarousel: true)) {
                                                        GiveawayCellFeature()
                                                    }
        
        await store.send(.setGiveawayImageContentMode(.fill))
        
        await store.receive(\.imageLoaderAction) {
            $0.imageLoaderState.contentMode = .fill
        }
    }
    
    // Test navigating to details action
    func testNavigateToDetailsAction() async {
        let store = TestStore(
            initialState: GiveawayCellFeature.State(id: UUID(),
                                                    imageName: "",
                                                    title: "Test Title",
                                                    description: "Test Description",
                                                    selectedGiveaway: Giveaway.mock,
                                                    isCarousel: true)) {
                                                        GiveawayCellFeature()
                                                    }
        
        await store.send(.navigateToDetails(true)) {
            $0.navigateToDetails = true
        }
        
        await store.send(.navigateToDetails(false)) {
            $0.navigateToDetails = false
        }
    }
}
