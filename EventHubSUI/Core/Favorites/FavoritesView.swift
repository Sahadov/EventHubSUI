//
//  FavoritesView.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        VStack {
            Text("FAVORITES")
                .foregroundStyle(.accentRed)
                .font(.Airbnb.light(size: 20))
            ImageLoaderView()
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    FavoritesView()
}

