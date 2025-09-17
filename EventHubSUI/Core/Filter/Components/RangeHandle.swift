//
//  RangeHandle.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct RangeHandle: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.white)
                .frame(width: 28, height: 28)
                .shadow(radius: 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.accentColor, lineWidth: 2)
                )
            
            HStack(spacing: 2) {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 6, height: 10)
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 6, height: 10)
            }
            .foregroundColor(.customGray)
        }
    }
}

#Preview {
    RangeHandle()
}
