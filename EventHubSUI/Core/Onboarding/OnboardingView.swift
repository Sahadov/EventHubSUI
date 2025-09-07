//
//  OnboardingView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            Text("ONBOARDING")
                .foregroundStyle(.accentRed)
                .font(.Airbnb.light(size: 20))
            ImageLoaderView()
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    OnboardingView()
}
