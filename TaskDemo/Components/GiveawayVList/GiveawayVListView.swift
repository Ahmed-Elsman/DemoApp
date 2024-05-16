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
        WithPerceptionTracking {
            WithViewStore(store, observe: { $0 }) { viewStore in
                GeometryReader { geometry in
                    listView(viewStore: viewStore)
                        .onAppear {
                            viewStore.send(.getGiveawaysList(frameWidth: geometry.size.width))
                        }
                }
            }
        }
    }
    
    private func listView(viewStore: ViewStore<GiveawayVListFeature.State, GiveawayVListFeature.Action>) -> some View {
        ScrollView {
            LazyVStack {
                if viewStore.isloading {
                    ProgressView()
                }
                ForEachStore(
                    store.scope(
                        state: \.giveawaysStatesList,
                        action: GiveawayVListFeature.Action.giveawayCellAction)) { childStore in
                            GiveawayCellView(store: childStore)
                        }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            .padding(.bottom, 16)
        }
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
