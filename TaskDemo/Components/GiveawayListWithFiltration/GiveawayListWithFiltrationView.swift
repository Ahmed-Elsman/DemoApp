//
//  GiveawayListWithFiltrationView.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 16/05/2024.
//

import SwiftUI
import ComposableArchitecture

struct GiveawayListWithFiltrationView: View {
    
    let store: StoreOf<GiveawayListWithFiltrationFeature>
    
    var body: some View {
            Color.white.ignoresSafeArea()
            LazyVStack(alignment: .leading, spacing: 0) {
                PlatformFilterListView(store: store.scope(state: \.filterList, action: \.filterListAction))
                
                GiveawayVListView(store: store.scope(state: \.giveawayVList, action: \.giveawayVListAction))
                    .padding(.horizontal, 16)
            }
    }
}


#Preview {
    ZStack(alignment: .top) {
        GiveawayListWithFiltrationView(store: Store(initialState: GiveawayListWithFiltrationFeature.State()) {
            GiveawayListWithFiltrationFeature()
        })
    }
}
