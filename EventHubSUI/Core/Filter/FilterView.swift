//
//  FilterView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct FilterView: View {
    @State private var minPrice: Double = 20
    @State private var maxPrice: Double = 120
    
    
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                heading(title: "Filter")
                
                VStack(alignment: .leading) {
                    heading(title: "Time & Date")
                    FilterButtonsView()
                }
            
                heading(title: "Location")
                LocationPickerView()
                
                HStack {
                    heading(title: "Select price range")
                    Spacer()
                    Text("$\(Int(minPrice)) -")
                        .font(.Airbnb.medium(size: 16))
                        .foregroundStyle(.accentBlue)
                    Text("$\(Int(maxPrice))")
                        .font(.Airbnb.medium(size: 16))
                        .foregroundStyle(.accentBlue)
                }
                .padding(.bottom)
                
                RangeSlider(minValue: $minPrice, maxValue: $maxPrice, range: 0.0...200.0)
                

                
                Spacer()
                
                HStack {
                    Button(action: {
                        
                    }) {
                        Text("Reset")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.secondary)
                    }
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .cornerRadius(10)
                    
                    Button(action: {
                        
                    }) {
                        Text("Apply")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentBlue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 24)
        }
    
    func heading(title: String) -> some View {
        Text(title)
            .font(.Airbnb.medium(size: 16))
    }
}

#Preview {
    FilterView()
}
