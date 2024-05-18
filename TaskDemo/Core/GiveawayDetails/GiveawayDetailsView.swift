//
//  GiveawayDetailsView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 15/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawayDetailsView: View {
    
    let store: StoreOf<GiveawayDetailsFeature>

    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                ZStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .top) {
                            
                            ImageLoaderView(store: store.scope(state: \.imageLoaderState, action: \.imageLoaderAction))
//                            .frame(width: viewStore.imageSize, height: viewStore.isCarousel ? viewStore.imageSize/2 : viewStore.imageSize)
                                .overlay(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.5), Color.black.opacity(0.5)]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                            
                            HStack {
                                Spacer()
                                Button(action: {
                                    // Action for bookmark button
                                }) {
                                    Image(systemName: "heart")
                                        .padding()
                                        .background(Color.black.opacity(0.5))
                                        .clipShape(Circle())
                                }
                                .padding(.top, 10)
                                .padding(.trailing, 10)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            HStack {
                                VStack {
                                    Image(systemName: "dollarsign.circle.fill")
                                    Text("\(viewStore.giveaway.worth)")
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Image(systemName: "person.2.fill")
                                    Text("\(viewStore.giveaway.users)")
                                }
                                
                                Spacer()
                                
                                VStack {
                                    Image(systemName: "gamecontroller.fill")
                                    Text("\(viewStore.giveaway.type)")
                                }
                            }
                            .font(.title2)
                            .foregroundColor(.black)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Platforms")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Text("\(viewStore.giveaway.platforms)")
                                    .font(.subheadline)
                                
                                Text("Giveaway End Date")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Text("\(viewStore.giveaway.endDate)")
                                    .font(.subheadline)
                                
                                Text("Description")
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                                
                                Text(viewStore.giveaway.description)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.top, 10)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding()
                }
                .background(Color.white.ignoresSafeArea())
            }
            .onAppear {
                viewStore.send(.setGiveawayImage(viewStore.giveaway.image))
                viewStore.send(.setGiveawayImageContentMode(ContentMode.fill))
            }
        }
    }
}

#Preview {
    NavigationView {
        GiveawayDetailsView(
            store: Store(initialState: GiveawayDetailsFeature.State(
                giveaway: Giveaway.mock)) {
                GiveawayDetailsFeature()
            }
        )
    }
}
