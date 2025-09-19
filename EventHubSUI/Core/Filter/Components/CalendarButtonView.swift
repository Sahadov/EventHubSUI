//
//  CalendarButtonView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct CalendarButtonView: View {
    @Binding var selectedDate: Date?
    @State private var showDatePicker = false
    
    private var formattedDate: String {
        guard let date = selectedDate else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
    var body: some View {
        HStack {
            Button(action: {
                showDatePicker.toggle()
            }) {
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.blue)
                    Text("Choose from calendar")
                        .font(.Airbnb.light(size: 15))
                        .foregroundColor(.secondary)
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            .sheet(isPresented: $showDatePicker) {
                VStack {
                    DatePicker(
                        "Select Date",
                        selection: Binding(
                            get: { selectedDate ?? Date() },
                            set: { selectedDate = $0 }
                        ),
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    .padding()
                    
                    Button("Done") {
                        showDatePicker = false
                    }
                    .padding()
                }
            }
        }
    }
}

// MARK: Preview
struct CalendarButtonView_Previews: PreviewProvider {
    @State static var date: Date? = Date()
    
    static var previews: some View {
        CalendarButtonView(selectedDate: $date)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
