//
//  GiveawayListWithFiltrationView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import SwiftUI
import Foundation
import ComposableArchitecture

struct GiveawayListWithFiltrationView: View {
    
    let store: StoreOf<GiveawayListWithFiltrationFeature>
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 8) {
                PlatformFilterListView(store: store.scope(state: \.filterList, action: \.filterList))
                
                GiveawayVListView(store: store.scope(state: \.giveawayVlist, action: \.giveawayVlist))
                    .padding(.horizontal, 16)
            }
        }
    }
}


#Preview {
    GiveawayListWithFiltrationView(store: Store(initialState: GiveawayListWithFiltrationFeature.State()) {
        GiveawayListWithFiltrationFeature()
    })
}
