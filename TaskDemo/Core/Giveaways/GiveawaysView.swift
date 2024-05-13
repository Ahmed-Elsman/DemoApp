//
//  ContentView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawaysView: View {
    
    let store: StoreOf<GiveawaysFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            ZStack(alignment: .top) {
                Color.white.ignoresSafeArea()
                ScrollView(.vertical) {
                    
                    
                    HStack(spacing: 0) {
                        HStack {
                            ZStack {
                                ImageLoaderView(imageUrlString: viewStore.currentUser.image)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                        }
                        .frame(width: 35, height: 35)
                    }
                    
                    LazyVStack {
                        if let giveaways = viewStore.giveaways {
                            ForEach(Array(giveaways)) { giveaway in
                                HStack {
                                    Text("\(giveaway.title)")
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
            .task {
                store.send(.getGiveaways)
            }
        }
    }
}

#Preview {
    GiveawaysView(store: Store(initialState: GiveawaysFeature.State()) {
        GiveawaysFeature()
    })
}
