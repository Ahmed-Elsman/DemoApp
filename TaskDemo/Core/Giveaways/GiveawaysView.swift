//
//  ContentView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import SwiftUI
import Foundation
import ComposableArchitecture

struct GiveawaysView: View {
    
    let store: StoreOf<ComposedFeature>
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                LazyVStack(spacing: 5) {
                    
                    headerView(viewStore: store.scope(state: \.giveawayhome, action: \.giveawayhome))
                        .padding(.horizontal, 16)
                    
                    Text("Explore \nGames Giveaways")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 16)
                    
                    GiveawayCarouslView(store: store.scope(state: \.giveawaylist, action: \.giveawaylist))
                    
                    GiveawayListWithFiltrationView(store: store.scope(state: \.giveawayListWithFilter, action: \.giveawayListWithFilter))
                    
                }
            }
        }
        .background(Color.white.ignoresSafeArea())
    }
    
    private func headerView(viewStore: StoreOf<GiveawaysFeature>) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("👋")
                Text("Hello, \(viewStore.currentUser.firstName)")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ImageLoaderView(store: viewStore.scope(state: \.imageLoaderState, action: \.imageLoaderState))
                .background(Color.white)
                .clipShape(Circle())
                .frame(width: 50)
        }
    }
}

struct GiveawaysView_Previews: PreviewProvider {
    static var previews: some View {
        GiveawaysView(store: Store(initialState: ComposedFeature.State()) {
            ComposedFeature()
        })
    }
}
