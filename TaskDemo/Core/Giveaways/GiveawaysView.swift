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
                if viewStore.isloading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                }
                ScrollView(.vertical) {
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
