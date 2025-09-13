//
//  FilterScrollView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 12.09.2025.
//

import SwiftUI


struct FilterScrollView: View {
    var onButtonTap: ((FilterCategory) -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(FilterCategory.allCases, id: \.self) { filter in
                Button {
                    onButtonTap?(filter)
                    print("Category taped: \(filter.title)") // for test
                } label: {
                    Text(filter.title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 106.77, height: 39.06)
                        .background(Color(hex: "#4A43EC"))
                        .cornerRadius(20.96)
                        .shadow(radius: 2, y: 1)
                }
                
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    FilterScrollView()
}
