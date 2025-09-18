//
//  FilterCategories.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct FilterCategories: View {
    var onCategorySelected: ((EventCategory) -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(EventCategory.allCases, id: \.self) { category in
                    Button {
                        onCategorySelected?(category)
                    } label: {
                        VStack(spacing: 5) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .fill(Color.white)
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                
                                Image(systemName: category.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.secondary)
                            }
                            
                            Text(category.title)
                                .foregroundColor(.primary)
                                .font(.Airbnb.light(size: 14))
                        }
                        .padding(.trailing, 10)
                    }
                }
            }
        }
        .padding(.top, 16)
    }
}


#Preview {
    FilterCategories()
}
