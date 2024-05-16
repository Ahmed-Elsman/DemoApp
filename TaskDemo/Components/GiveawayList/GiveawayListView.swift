//
//  GiveawayListView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 15/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawayListView: View {
    let store: StoreOf<GiveawayListFeature>
    
    var body: some View {
        WithPerceptionTracking {
            WithViewStore(store, observe: { $0 }) { viewStore in
                carouslView(viewStore: viewStore)
            }
        }
    }
    
    private func carouslView(viewStore: ViewStore<GiveawayListFeature.State, GiveawayListFeature.Action>) -> some View {
        LazyVStack {
            if viewStore.isloading {
                ProgressView()
            }
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 16) {
                    ForEachStore(
                        store.scope(
                            state: \.giveawaysStatesList,
                            action: GiveawayListFeature.Action.giveawayCellAction)) { childStore in
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
        GiveawayListView(
            store: Store(
                initialState: GiveawayListFeature.State()
            ) {
                GiveawayListFeature()
            }
        )
    }
}
