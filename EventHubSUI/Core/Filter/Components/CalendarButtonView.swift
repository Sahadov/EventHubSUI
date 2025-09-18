//
//  CalendarButtonView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct CalendarButtonView: View {
    @State private var selectedDate: Date? = nil
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
                        .foregroundColor(.blue)
                }
                .padding()
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
            Spacer()
            
            if let date = selectedDate {
                Text(formattedDate)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct CalendarButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarButtonView()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
