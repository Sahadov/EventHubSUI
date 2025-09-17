//
//  ExploreSearchBar.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI

struct ExploreSearchBar: View {
    @Binding var text: String
    var iconColor: Color = .white
    var placeholder: String = "Search..."
    
    var asButton: Bool = false  
    var onRightButtonTap: (() -> Void)? = nil
    var onTapSearchBar: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            if asButton {
                Button {
                    onTapSearchBar?()
                } label: {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white)
                        Text(placeholder)
                            .foregroundColor(.white.opacity(0.7))
                        Spacer()
                    }
                    .padding(8)
                    .background(Color.clear)
                    .cornerRadius(12)
                }
            } else {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(iconColor)
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .foregroundColor(.gray)
                }
                .padding(8)
                .background(Color.clear)
                .cornerRadius(12)
            }
            
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
        },
        onTapSearchBar: {
            print("search tapped")
        }
    )
    .background(Color.blue)
}


