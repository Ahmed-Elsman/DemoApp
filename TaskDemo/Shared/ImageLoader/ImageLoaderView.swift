//
//  ImageLoaderView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import SwiftUI
import ComposableArchitecture
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    let store: StoreOf<ImageLoaderFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            Rectangle()
                .opacity(0.0001)
                .overlay(
                    WebImage(url: URL(string: viewStore.imageUrlString))
                        .resizable()
                        .indicator(.activity)
                        .aspectRatio(contentMode: viewStore.contentMode)
                        .allowsHitTesting(false)
                )
                .clipped()
                .onAppear {
                    viewStore.send(.loadImage)
                }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ImageLoaderView(
            store: Store(
                initialState: ImageLoaderFeature.State(
                    imageUrlString: Constants.randomImage,
                    contentMode: .fill
                )
            ) {
                ImageLoaderFeature()
            }
        )
        .cornerRadius(20)
        .padding(40)
        .padding(.vertical, 60)
    }
}
