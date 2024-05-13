//
//  ImageLoaderView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoaderView: View {
    
    var imageUrlString: String = Constants.randomImage
    var contentMode: ContentMode = .fill
    
    var body: some View {
        Rectangle()
            .opacity(0.0001)
            .overlay(
                WebImage(url: URL(string: imageUrlString))
                    .resizable()
                    .indicator(.activity)
                    .aspectRatio(contentMode: contentMode)
                    .allowsHitTesting(false)
            )
            .clipped()
    }
}

#Preview {
    ImageLoaderView()
        .cornerRadius(20)
        .padding(40)
        .padding(.vertical, 60)
}
