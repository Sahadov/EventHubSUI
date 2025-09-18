//
//  LocationPickerView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct LocationPickerView: View {
    @State private var selectedLocation: LocationsList = .spb
    
    var body: some View {
        HStack {
            Image(systemName: "map")
                .foregroundColor(.accentColor)
            
            Picker("Location", selection: $selectedLocation) {
                ForEach(LocationsList.allCases, id: \.self) { location in
                    Text(location.title).tag(location)
                }
            }
            .pickerStyle(MenuPickerStyle()) // стиль выпадающего меню
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
    }
}

#Preview {
    LocationPickerView()
}
