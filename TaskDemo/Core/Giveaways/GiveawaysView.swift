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

                        headerView(store: store.scope(state: \.giveaway, action: \.giveawayAction))
                            .padding(.horizontal, 16)

                        Text("Explore \nGames Giveaways")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 16)

                        GiveawayCarouselView(store: store.scope(state: \.giveawayCarousel, action: \.giveawayCarouselAction))

                        GiveawayListWithFiltrationView(store: store.scope(state: \.giveawayListWithFilter, action: \.giveawayListWithFilterAction))
                    }
                }
                .background(Color.primaryColor.ignoresSafeArea())
            }
        }
    }

    private func headerView(store: StoreOf<GiveawaysFeature>) -> some View {

        HStack {
            if let currentUser = store.currentUser {
                VStack(alignment: .leading) {
                    Text("👋")
                    Text("Hello, \(currentUser.name)")
                        .font(.title3)
                        .fontWeight(.medium)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ImageLoaderView(store: store.scope(state: \.imageLoaderState, action: \.imageLoaderAction))
                    .background(Color.primaryColor)
                    .clipShape(Circle())
                    .frame(width: 50)
            }
        }
        .onAppear {
            store.send(.setCurrentUser(User.mock))
            store.send(.setUserImageContentMode(.fill))
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
