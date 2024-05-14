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
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack(alignment: .top) {
                Color.white.ignoresSafeArea()
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 8) {
                        headerView(viewStore: viewStore)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Explore \nGames Giveaways")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal, 16)
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
                }
            }
            .task {
                store.send(.getGiveaways)
            }
        }
    }
    
    private func headerView(viewStore: ViewStore<GiveawaysFeature.State, GiveawaysFeature.Action>) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("👋")
                Text("Hello, \(viewStore.currentUser.firstName)")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ImageLoaderView(
                store: Store(
                    initialState: ImageLoaderFeature.State(
                        imageUrlString: viewStore.currentUser.image,
                        contentMode: .fill)) {
                            ImageLoaderFeature()
                        }
            )
            .background(.white)
            .clipShape(Circle())
            .frame(width: 50)
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    GiveawaysView(store: Store(initialState: GiveawaysFeature.State()) {
        GiveawaysFeature()
    })
}
