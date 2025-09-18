//
//  FilterCategories.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct FilterCategories: View {
    var onCategorySelected: ((Set<EventCategory>) -> Void)? = nil
    @State private var selectedCategories: Set<EventCategory> = []
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(EventCategory.allCases, id: \.self) { category in
                    Button {
                        withAnimation(.easeInOut) {
                            if selectedCategories.contains(category) {
                                selectedCategories.remove(category)
                            } else {
                                selectedCategories.insert(category)
                            }
                            onCategorySelected?(selectedCategories)
                        }
                    } label: {
                        VStack(spacing: 10) {
                            ZStack {
                                Circle()
                                    .fill(selectedCategories.contains(category) ? Color.blue : Color.white)
                                    .frame(width: 64, height: 64)
                                    .overlay(
                                        Circle()
                                            .strokeBorder(Color.gray, lineWidth: 1)
                                    )
                                    .shadow(color: selectedCategories.contains(category) ? Color.blue.opacity(0.3) : Color.clear,
                                                                                radius: 5, x: 0, y: 4)
                                
                                Image(systemName: category.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(selectedCategories.contains(category) ? Color.white : Color.secondary)
                            }
                            
                            Text(category.title)
                                .foregroundColor(.primary)
                                .font(.Airbnb.light(size: 14))
                        }
                        .padding(.trailing, 5)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top, 16)
    }
}


#Preview {
    FilterCategories()
}
