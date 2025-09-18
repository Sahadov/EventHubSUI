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
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                ForEach(FilterOption.allCases, id: \.self) { option in
                    Button(action: {
                        selected = option
                    }) {
                        Text(option.rawValue)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .frame(minWidth: 80)
                            .background(
                                selected == option
                                ? Color.blue
                                : Color.clear
                            )
                            .foregroundColor(
                                selected == option
                                ? .white
                                : .secondary
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        selected == option ? Color.blue : Color.gray,
                                        lineWidth: 1
                                    )
                            )
                            .cornerRadius(8)
                    }
                }
            }
            CalendarButtonView()
        }
    }
}

#Preview {
    FilterButtonsView()
}
