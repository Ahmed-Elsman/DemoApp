//
//  GiveawayCell.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 13/05/2024.
//

import SwiftUI

struct GiveawayCell: View {
    
    var imageSize: CGFloat = 300
    var imageName: String = Constants.randomImage
    var title: String = "MechDefender (IndieGala) Giveaway"
    var description: String = "Download MechDefender for free via IndieGala! MechDefender is an indie top-down shooter with tower defense features."
    
    var body: some View {
        
        ZStack(alignment:.top) {
            ImageLoaderView(imageUrlString: imageName)
                .frame(width: imageSize, height: imageSize/2)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0.5), Color.black.opacity(0.5), Color.black.opacity(0.5)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            VStack(alignment: .leading) {
                Text(title)
                    .font(.callout)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .font(.caption)
                    .fontWeight(.bold)
                    .lineLimit(3)
                    .foregroundStyle(Color.white.opacity(0.5))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .padding(14)
        }
        .frame(width: imageSize, height: imageSize/2)
        .cornerRadius(15)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        GiveawayCell()
    }
}
