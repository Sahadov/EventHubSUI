//
//  FilterButtonsView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

enum FilterOption: String, CaseIterable {
    case today = "Today"
    case tomorrow = "Tomorrow"
    case thisWeek = "This week"
}

struct FilterButtonsView: View {
    @State private var selected: FilterOption? = nil
    @State private var selectedDate: Date? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: Filter buttons
            HStack(spacing: 12) {
                ForEach(FilterOption.allCases, id: \.self) { option in
                    Button(action: {
                        selected = option
                        selectedDate = nil
                    }) {
                        Text(option.rawValue)
                            .font(.system(size: 15, weight: .medium))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .frame(minWidth: 80)
                            .background(
                                (selected == option && selectedDate == nil) ? Color.blue : Color.clear
                            )
                            .foregroundColor(
                                (selected == option && selectedDate == nil) ? .white : .secondary
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        (selected == option && selectedDate == nil) ? Color.blue : Color.gray,
                                        lineWidth: 1
                                    )
                            )
                            .cornerRadius(8)
                    }
                }
            }
            
            // MARK: Calendar button
            CalendarButtonView(selectedDate: $selectedDate)
        }
        .padding(.vertical)
    }
}

#Preview {
    FilterButtonsView()
}
