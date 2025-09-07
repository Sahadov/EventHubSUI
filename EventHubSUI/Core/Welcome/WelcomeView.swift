//
//  WelcomeView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("WELCOME")
                .foregroundStyle(.accentRed)
                .font(.Airbnb.light(size: 20))
            ImageLoaderView()
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    WelcomeView()
}
