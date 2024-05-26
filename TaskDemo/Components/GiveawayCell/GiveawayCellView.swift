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
                    store: Store(initialState: GiveawayDetailsFeature.State(giveaway: viewStore.selectedGiveaway)) {
                        GiveawayDetailsFeature()
                    }
                ),
                isActive: viewStore.binding(
                    get: \.navigateToDetails,
                    send: GiveawayCellFeature.Action.navigateToDetails
                )) {
                ZStack(alignment: .top) {
                    ImageLoaderView(store: store.scope(state: \.imageLoaderState, action: \.imageLoaderAction))
                        .frame(width: viewStore.imageSize, height: viewStore.isCarousel ? viewStore.imageSize/2 : viewStore.imageSize)
                        .gradientOverlay()

                    cellDetails(viewStore: viewStore)
                    .padding(14)
                }
                .frame(width: viewStore.imageSize, height: viewStore.isCarousel ? viewStore.imageSize/2 : viewStore.imageSize)
                .cornerRadius(15)
                .onTapGesture {
                    viewStore.send(.giveawayTapped(viewStore.selectedGiveaway))
                }
                .onAppear {
                    viewStore.send(.setGiveawayImage(viewStore.imageUrl))
                    viewStore.send(.setGiveawayImageContentMode(ContentMode.fill))
                }
            }
        }
    }

    private func cellDetails(viewStore: ViewStore<GiveawayCellFeature.State, GiveawayCellFeature.Action>) -> some View {
        VStack(alignment: .leading) {
            Text(viewStore.title)
                .font(.callout)
                .fontWeight(.bold)
                .lineLimit(2)
                .foregroundColor(Color.primaryColor)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(viewStore.description)
                .font(.caption)
                .fontWeight(.bold)
                .lineLimit(3)
                .foregroundColor(Color.primaryColor.opacity(0.7))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        }
    }
}

#Preview {
    ZStack {
        Color.secondaryColor.ignoresSafeArea()
        GiveawayCellView(
            store: Store(
                initialState: GiveawayCellFeature.State(
                    id: UUID(),
                    imageUrl: "https://picsum.photos/600/600",
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
