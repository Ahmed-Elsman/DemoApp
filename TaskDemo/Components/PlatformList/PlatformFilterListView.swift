//
//  PlatformFilterListView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PlatformFilterListView: View {
    let store: StoreOf<PlatformFilterListFeature>
    
    var body: some View {
        WithPerceptionTracking {
            WithViewStore(store, observe: { $0 }) { viewStore in
                filterationView(viewStore: viewStore)
            }
        }
    }
    
    private func filterationView(viewStore: ViewStore<PlatformFilterListFeature.State, PlatformFilterListFeature.Action>) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEachStore(
                    store.scope(
                        state: \.platformStatesList,
                        action: PlatformFilterListFeature.Action.platformCellAction)) { childStore in
                            PlatformCellView(store: childStore)
                        }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            viewStore.send(.setPlatforms)
        }
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        PlatformFilterListView(
            store: Store(
                initialState: PlatformFilterListFeature.State()
            ) {
                PlatformFilterListFeature()
            }
        )
    }
}
