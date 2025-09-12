//
//  ExploreSearchBar.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreSearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search"
    var onRightButtonTap: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(8)
            .background(Color.clear)
            .cornerRadius(12)
            
            if let onRightButtonTap = onRightButtonTap {
                Button(action: onRightButtonTap) {
                    Image(.filtres)
                        .padding(8)
                        .cornerRadius(8)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    @State var searchText = ""
    
    return ExploreSearchBar(
        text: $searchText,
        placeholder: "Search...",
        onRightButtonTap: {
            print("tapped")
        }
    )
    
}
