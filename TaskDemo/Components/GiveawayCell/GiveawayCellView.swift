//
//  GiveawayCell.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawayCellView: View {
    let store: StoreOf<GiveawayCellFeature>
    
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            NavigationLink(
                destination: GiveawayDetailsView(
                    store: Store(
                        initialState: GiveawayDetailsFeature.State(giveaway: viewStore.selectedGiveaway)
                    ) {
                        GiveawayDetailsFeature()
                    }
                ),
                isActive: viewStore.binding(
                    get: \.navigateToDetails,
                    send: GiveawayCellFeature.Action.navigateToDetails
                )
            ) {
                ZStack(alignment:.top) {
                    
                    ImageLoaderView(store: store.scope(state: \.imageLoaderState, action: \.imageLoaderAction))
                        .frame(width: viewStore.imageSize, height: viewStore.isCarousel ? viewStore.imageSize/2 : viewStore.imageSize)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.5), Color.black.opacity(0.5)]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    VStack(alignment: .leading) {
                        Text(viewStore.title)
                            .font(.callout)
                            .fontWeight(.bold)
                            .lineLimit(2)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(viewStore.description)
                            .font(.caption)
                            .fontWeight(.bold)
                            .lineLimit(3)
                            .foregroundColor(Color.white.opacity(0.5))
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                    .padding(14)
                }
                .frame(width: viewStore.imageSize, height: viewStore.isCarousel ? viewStore.imageSize/2 : viewStore.imageSize)
                .cornerRadius(15)
                .onTapGesture {
                    viewStore.send(.giveawayTapped(viewStore.selectedGiveaway))
                }
                .onAppear {
                    viewStore.send(.setGiveawayImage(viewStore.imageName))
                    viewStore.send(.setGiveawayImageContentMode(ContentMode.fill))
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        GiveawayCellView(
            store: Store(
                initialState: GiveawayCellFeature.State(
                    id: UUID(),
                    imageName: Constants.randomImage,
                    title: "",
                    description: "",
                    selectedGiveaway: Giveaway.mock,
                    isCarousel: true
                )
            ) {
                GiveawayCellFeature()
            }
        )
    }
}
