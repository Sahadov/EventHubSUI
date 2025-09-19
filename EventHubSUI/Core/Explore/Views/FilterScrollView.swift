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
                    Text(filter.title.uppercased())
//                        .font(.system(size: 14, weight: .bold))
                        .font(.Airbnb.medium(size: 13))
                        .foregroundColor(.white)
                        .frame(width: 107, height: 42)
                        .background(Color(hex: "#4A43EC"))
                        .cornerRadius(21)
//                        .shadow(radius: 2, y: 1)
                }
                
            }
        }
//        .padding(.horizontal, 24)
    }
}


#Preview {
    FilterScrollView()
}
