//
//  GiveawayListView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 15/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawayCarouslView: View {
    let store: StoreOf<GiveawayCarouslFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            carouslView(viewStore: viewStore)
        }
    }
    
    private func carouslView(viewStore: ViewStore<GiveawayCarouslFeature.State, GiveawayCarouslFeature.Action>) -> some View {
        LazyVStack {
            if viewStore.isloading {
                ProgressView()
            }
            ScrollView(.horizontal) {
                LazyHStack(alignment: .top, spacing: 16) {
                    ForEachStore(
                        store.scope(
                            state: \.giveawaysStatesList,
                            action: GiveawayCarouslFeature.Action.giveawayCellAction)) { childStore in
                                GiveawayCellView(store: childStore)
                            }
                }
                .padding(.leading, 16)
            }
        } .onAppear {
            viewStore.send(.getGiveaways)
        }
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        GiveawayCarouslView(
            store: Store(
                initialState: GiveawayCarouslFeature.State()
            ) {
                GiveawayCarouslFeature()
            }
        )
    }
}
