//
//  View + Ext.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

extension View {
    func shimmering(active: Bool = true) -> some View {
        self
            .redacted(reason: active ? .placeholder : [])
            .overlay(
                Group {
                    if active {
                        GeometryReader { geometry in
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .clear,
                                    .white.opacity(0.4),
                                    .white.opacity(0.8),
                                    .white.opacity(0.4),
                                    .clear
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .frame(width: geometry.size.width * 2)
                            .rotationEffect(.degrees(-30))
                            .modifier(ShimmerAnimationModifier(width: geometry.size.width))
                        }
                        .mask(self)
                    }
                }
            )
    }
}

struct ShimmerAnimationModifier: ViewModifier {
    let width: CGFloat
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .offset(x: phase * width * 3 - width)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

//MARK: - NavbarStyle
// Вместе с  .navigationBarBackButtonHidden(true)


struct SearchNavigationStyle: ViewModifier {
    let title: String
    let dismissAction: () -> Void

    func body(content: Content) -> some View {
        content
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { dismissAction() } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.system(size: 20, weight: .semibold))
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

extension View {
    func searchNavigationStyle(title: String, dismissAction: @escaping () -> Void) -> some View {
        self.modifier(SearchNavigationStyle(title: title, dismissAction: dismissAction))
    }
}
