//
//  LocationPickerView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct LocationPickerView: View {
    @Binding var selectedLocation: LocationsList
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.accentColor)
                    .frame(width: 40, height: 40)
                    .opacity(0.3)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white)
                    .frame(width: 25, height: 25)
                    .shadow(radius: 2)
                
                Image("filter-pin")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 14, height: 14)
                    .foregroundColor(.accentColor)
            }
            
            Menu {
                ForEach(LocationsList.allCases, id: \.self) { location in
                    Button {
                        selectedLocation = location
                    } label: {
                        Text(location.title)
                            .font(.Airbnb.light(size: 15))
                            .foregroundColor(.primary)
                    }
                }
            } label: {
                HStack {
                    Text(selectedLocation.title)
                        .font(.Airbnb.light(size: 15))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.accentBlue)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
        )
        .buttonStyle(PlainButtonStyle())
        .frame(maxWidth: .infinity)
    }
}

