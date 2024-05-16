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
                Text("\(viewStore.giveaway ?? "")")
            }
            .navigationTitle(Text(viewStore.giveaway ?? ""))
            .onAppear {
                // add here setting data for view
            }
        }
    }
}

#Preview {
    NavigationStack {
        GiveawayDetailsView(store: Store(initialState: GiveawayDetailsFeature.State(giveaway: Giveaway.mock.title), reducer: {
            GiveawayDetailsFeature()
        }))
    }
}
