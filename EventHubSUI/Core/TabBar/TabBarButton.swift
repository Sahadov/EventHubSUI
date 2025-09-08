//
//  TabBarButton.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import Foundation
import SwiftUI

struct TabButton: View {
        
    let tab: TabBookmarksEnum
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(tab.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(.black)
                .background {
                    if isSelected {
                        Color.blue.opacity(0.2)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .frame(width: 22, height: 22)
                    }
                }
        }
    }
}
