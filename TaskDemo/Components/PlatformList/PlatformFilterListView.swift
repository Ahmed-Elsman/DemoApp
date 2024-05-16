//
//  PlatformFliterListView.swift
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
                ForEach(Platform.allCases, id: \.self) { platform in
                    PlatformCellView(
                        store: Store(
                            initialState: PlatformCellFeature.State(
                                title: platform.rawValue,
                                isSelected: viewStore.selectedPlatform == platform
                            )
                        ) {
                            PlatformCellFeature()
                        }
                    ).onTapGesture {
                        viewStore.send(.selectPlatform(platform))
                    }
                }
            }
            .padding(.horizontal, 16)
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
