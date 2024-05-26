//
//  ComposedFeatureTests.swift
//  TaskDemoTests
//
//  Created by Ahmed Elsman on 18/05/2024.
//

import XCTest
import ComposableArchitecture
@testable import TaskDemo

@MainActor
final class ComposedFeatureTests: XCTestCase {

    struct MockData {
        static let giveaways = Giveaway.mockedArray
    }

    // Test setting all giveaways for filtration
    func testSetAllGiveawaysForFiltration() async {
        let store = TestStore(
            initialState: ComposedFeature.State()) {
                ComposedFeature()
            }

        store.exhaustivity = .off
    }
}
