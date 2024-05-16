//
//  PlatformCellView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 14/05/2024.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PlatformCellView: View {
    
    let store: StoreOf<PlatformCellFeature>
    
    var body: some View {
        WithViewStore(store, observe: {$0}) { viewStore in
            Text(viewStore.title)
                .font(.callout)
                .fontWeight(viewStore.isSelected ? .bold : .medium)
                .frame(minWidth: 30)
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .foregroundColor(viewStore.isSelected ? .black : .gray)
                .cornerRadius(15)
                .onTapGesture {
                    viewStore.send(.selectPlatfrom(viewStore.platform))
                }
        }
    }
}

#Preview {
    ZStack {
        Color.white.ignoresSafeArea()
        HStack {
            PlatformCellView(
                store: Store(
                    initialState: PlatformCellFeature.State(
                        id: UUID(),
                        title: "all",
                        isSelected: true,
                        platform: Platform.all
                    )
                ) {
                    PlatformCellFeature()
                }
            )
            
            PlatformCellView(
                store: Store(
                    initialState: PlatformCellFeature.State(
                        id: UUID(),
                        title: "all",
                        isSelected: false,
                        platform: Platform.all
                    )
                ) {
                    PlatformCellFeature()
                }
            )
        }
    }
    
}
