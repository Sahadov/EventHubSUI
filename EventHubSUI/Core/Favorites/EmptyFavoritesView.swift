//
//  EmptyFavoritesView.swift
//  EventHubSUI
//
//  Created by Артур  Арсланов on 10.09.2025.
//

import SwiftUI

struct EmptyFavoritesView: View {
    var body: some View {
        VStack(spacing: 50) {
            Text("NO FAVORITES")
                .font(.Airbnb.bold(size: 24))
                .foregroundColor(.primary)

            ZStack {
                Image("Vector")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 137, height: 144)
                Image(systemName: "xmark")
                    .font(.system(size: 30, weight: .thin))
                    .offset(y: -18)
            }
            .foregroundColor(.red)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}


#Preview {
    EmptyFavoritesView()
}
