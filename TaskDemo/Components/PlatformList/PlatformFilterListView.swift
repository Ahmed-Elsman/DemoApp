//
//  PlatformFilterListView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct PlatformFilterListView: View {
    let store: StoreOf<PlatformFilterListFeature>

    var body: some View {
        filtrationView(store: store)
    }

    private func filtrationView(store: StoreOf<PlatformFilterListFeature>) -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 8) {
                ForEachStore(
                    store.scope(
                        state: \.platformStatesList,
                        action: \.platformCellAction)) { platformCellStore in
                            PlatformCellView(store: platformCellStore)
                        }
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
            store.send(.setPlatforms)
        }
    }
}

#Preview {
    ZStack {
        Color.primaryColor.ignoresSafeArea()
        PlatformFilterListView(
            store: Store(
                initialState: PlatformFilterListFeature.State()
            ) {
                PlatformFilterListFeature()
            }
        )
    }
}
