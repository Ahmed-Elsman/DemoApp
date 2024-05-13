//
//  TaskDemoApp.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct TaskDemoApp: App {
    var body: some Scene {
        WindowGroup {
            GiveawaysView(store: Store(initialState: GiveawaysFeature.State()) {
                GiveawaysFeature()
                    ._printChanges()
            })
        }
    }
}
