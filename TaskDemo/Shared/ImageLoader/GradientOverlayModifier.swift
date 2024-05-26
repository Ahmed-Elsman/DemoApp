//
//  GradientOverlayModifier.swift
//  TaskDemo
//
//  Created by Ahmed Elsman on 26/05/2024.
//

import SwiftUI

struct GradientOverlayModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [Color.secondaryColor.opacity(0.5), Color.secondaryColor.opacity(0.5), Color.secondaryColor.opacity(0.5)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}

extension View {
    func gradientOverlay() -> some View {
        self.modifier(GradientOverlayModifier())
    }
}
