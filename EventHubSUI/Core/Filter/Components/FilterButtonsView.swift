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
    @Binding var startDate: Date?
    @Binding var endDate: Date?
    
    private let calendar = Calendar.current
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            // MARK: Filter buttons
            HStack(spacing: 12) {
                ForEach(FilterOption.allCases, id: \.self) { option in
                    Button {
                        applyFilter(option)
                    } label: {
                        Text(option.rawValue)
                            .font(.system(size: 15, weight: .medium))
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .frame(minWidth: 80)
                            .background(isSelected(option) ? Color.blue : Color.clear)
                            .foregroundColor(isSelected(option) ? .white : .secondary)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(isSelected(option) ? Color.blue : Color.gray, lineWidth: 1)
                            )
                            .cornerRadius(8)
                    }
                }
                
                
            }
            
            // MARK: Calendar button
            HStack {
                
                CalendarButtonView(
                    selectedDate: Binding(
                        get: { startDate },
                        set: { newDate in
                            startDate = newDate
                            endDate = nil
                        }
                    )
                )
                
                Spacer()
                
                // MARK: Если выбрана только одна дата (не диапазон)
                if let start = startDate, endDate == nil {
                    Text(dateFormatter.string(from: start))
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
            
            
            // MARK: Если диапазон (This week) — снизу под календарём
            if let start = startDate, let end = endDate {
                Text(displayedDateRange())
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
    }
    
    private func applyFilter(_ option: FilterOption) {
        let today = calendar.startOfDay(for: Date())
        
        switch option {
        case .today:
            startDate = today
            endDate = nil
        case .tomorrow:
            if let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) {
                startDate = tomorrow
                endDate = nil
            }
        case .thisWeek:
            if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
                startDate = weekInterval.start
                endDate = weekInterval.end
            }
        }
    }
    
    private func isSelected(_ option: FilterOption) -> Bool {
        guard let startDate = startDate else { return false }
        let today = calendar.startOfDay(for: Date())
        
        switch option {
        case .today:
            return calendar.isDate(startDate, inSameDayAs: today)
        case .tomorrow:
            if let tomorrow = calendar.date(byAdding: .day, value: 1, to: today) {
                return calendar.isDate(startDate, inSameDayAs: tomorrow)
            }
            return false
        case .thisWeek:
            if let end = endDate,
               let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
                return calendar.isDate(startDate, inSameDayAs: weekInterval.start) &&
                       calendar.isDate(end, inSameDayAs: weekInterval.end)
            }
            return false
        }
    }
    
    private func displayedDateRange() -> String {
        if let start = startDate, let end = endDate {
            return "\(dateFormatter.string(from: start)) – \(dateFormatter.string(from: end))"
        } else if let start = startDate {
            return dateFormatter.string(from: start)
        } else {
            return ""
        }
    }
}


