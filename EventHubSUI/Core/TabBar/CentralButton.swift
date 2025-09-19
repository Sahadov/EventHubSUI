//
//  CentralButton.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct CentralButton: View {
    @Binding var selected: TabBookmarksEnum
    var index: TabBookmarksEnum
    
    var body: some View {
        Button {
        selected = index
        } label: {
            ZStack {
                Circle()
                    .fill(Color(hex: "#5669ff"))
                    .frame(width: 46, height: 46)
                    .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 4)
                  
                
                Image(.centerButton)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 23, height: 23)
                
            }
        }

    }
}
