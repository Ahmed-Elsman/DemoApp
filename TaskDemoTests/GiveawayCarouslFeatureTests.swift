//
//  GiveawayCarouslFeatureTests.swift
//  TaskDemoTests
//
//  Created by Ahmed Elsman on 18/05/2024.
//

import XCTest
import ComposableArchitecture
@testable import TaskDemo

@MainActor
final class GiveawayCarouselFeatureTests: XCTestCase {
    
    // Test fetching giveaways action
    func testGetGiveawaysAction() async {
        let store = TestStore(
            initialState: GiveawayCarouslFeature.State()) {
                GiveawayCarouslFeature()
            }
        
        await store.send(.getGiveaways) {
            $0.isloading = true
        }
        
        await store.receive(\.giveawaysResponse) {
            $0.isloading = false
            $0.giveaways = [Giveaway.mock]
            $0.giveawaysStatesList = IdentifiedArray(uniqueElements: [
                GiveawayCellFeature.State(id: UUID(), imageName: Giveaway.mock.image, title: Giveaway.mock.title, description: Giveaway.mock.description, selectedGiveaway: Giveaway.mock, isCarousel: true)
            ])
            $0.giveawaysLoaded = true
        }
        
        await store.receive(\.setAllGiveawaysForFiltration)
    }
}
