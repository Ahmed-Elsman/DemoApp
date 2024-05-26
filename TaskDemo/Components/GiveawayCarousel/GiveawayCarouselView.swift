//
//  GiveawayListView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 15/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawayCarouselView: View {
    let store: StoreOf<GiveawayCarouselFeature>

    var body: some View {
        carouselView(store: store)
            .onAppear {
                if !store.giveawaysLoaded {
                    store.send(.getGiveaways)
                }
            }
    }

    private func carouselView(store: StoreOf<GiveawayCarouselFeature>) -> some View {
        VStack {
            if store.isLoading {
                ProgressView()
            }
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEachStore(
                        store.scope(
                            state: \.giveawaysStatesList,
                            action: \.giveawayCellAction)) {
                                GiveawayCellView(store: $0)
                            }
                }
                .padding(.leading, 16)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.primaryColor.ignoresSafeArea()
        GiveawayCarouselView(
            store: Store(
                initialState: GiveawayCarouselFeature.State()
            ) {
                GiveawayCarouselFeature()
            }
        )
    }
}
