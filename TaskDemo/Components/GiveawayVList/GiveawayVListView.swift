//
//  GiveawayVListView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawayVListView: View {
    let store: StoreOf<GiveawayVListFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            listView(viewStore: viewStore)
        }
    }
    
    private func listView(viewStore: ViewStore<GiveawayVListFeature.State, GiveawayVListFeature.Action>) -> some View {
        LazyVStack {
            if viewStore.isLoading {
                ProgressView()
            }
            ForEachStore(
                store.scope(
                    state: \.filteredGiveawaysStatesList,
                    action: GiveawayVListFeature.Action.giveawayCellAction)) { childStore in
                        GiveawayCellView(store: childStore)
                    }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        GiveawayVListView(
            store: Store(
                initialState: GiveawayVListFeature.State()
            ) {
                GiveawayVListFeature()
            }
        )
    }
}
