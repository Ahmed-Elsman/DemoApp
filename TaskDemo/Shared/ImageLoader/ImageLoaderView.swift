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
        
        WithViewStore(store, observe: { $0 }) { viewStore in
            if let imageString = viewStore.imageUrlString,
               let contentMode = viewStore.contentMode {
                Rectangle()
                    .opacity(0.0001)
                    .overlay(
                        WebImage(url: URL(string: imageString))
                            .resizable()
                            .indicator(.activity)
                            .aspectRatio(contentMode: contentMode)
                            .allowsHitTesting(false)
                    )
                    .clipped()
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
                    imageUrlString: "https://picsum.photos/600/600",
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

