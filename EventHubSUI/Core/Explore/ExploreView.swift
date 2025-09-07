//
//  ExploreView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct ExploreView: View {
    
    var body: some View {
        VStack {
            Text("EXPLORE")
                .foregroundStyle(.accentRed)
                .font(.Airbnb.light(size: 20))
            ImageLoaderView()
                .frame(width: 100, height: 100)
        }
        
    }
}

#Preview {
    ExploreView()
}
