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
                Text("\(viewStore.giveaway?.title ?? "")")
            }
            .navigationTitle(Text(viewStore.giveaway?.title ?? ""))
            .onAppear {
                // add here setting data for view
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
