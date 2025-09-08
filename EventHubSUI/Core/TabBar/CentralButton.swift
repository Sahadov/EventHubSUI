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
                    .fill(Color.blue)
                    .frame(width: 44, height: 44)
                  
                
                Image("bookmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                
            }
        }

    }
}
