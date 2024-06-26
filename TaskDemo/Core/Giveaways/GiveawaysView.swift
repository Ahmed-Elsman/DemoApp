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
        NavigationView {
            ScrollView {
                ZStack(alignment: .top) {
                    LazyVStack(spacing: 5) {
                        
                        headerView(viewStore: store.scope(state: \.giveaway, action: \.giveawayAction))
                            .padding(.horizontal, 16)
                        
                        Text("Explore \nGames Giveaways")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)
                        
                        GiveawayCarouslView(store: store.scope(state: \.giveawayCarousl, action: \.giveawayCarouslAction))
                        
                        GiveawayListWithFiltrationView(store: store.scope(state: \.giveawayListWithFilter, action: \.giveawayListWithFilterAction))
                    }
                }
                .background(Color.white.ignoresSafeArea())
            }
        }
    }
    
    private func headerView(viewStore: StoreOf<GiveawaysFeature>) -> some View {
        
        HStack {
            if let currentUser = viewStore.currentUser {
                VStack(alignment: .leading) {
                    Text("👋")
                    Text("Hello, \(currentUser.firstName)")
                        .font(.title3)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                ImageLoaderView(store: viewStore.scope(state: \.imageLoaderState, action: \.imageLoaderAction))
                    .background(Color.white)
                    .clipShape(Circle())
                    .frame(width: 50)
            }
        }
        .onAppear {
            viewStore.send(.setCurrentUser(User.mock))
            viewStore.send(.setUserImageContentMode(.fill))
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
