//
//  FilterView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct FilterView: View {
    @StateObject private var viewModel = FilterViewModel()
    @Binding var isPresented: Bool

    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("Filter")
                    .font(.Airbnb.medium(size: 25))
                
                FilterCategories(
                    selectedCategories: Binding(
                        get: {
                            Set(viewModel.preferences.selectedCategories.compactMap(EventCategory.init(rawValue:)))
                        },
                        set: { newSet in
                            viewModel.preferences.selectedCategories = newSet.map { $0.rawValue }
                        }
                    )
                )
                
                VStack(alignment: .leading) {
                    heading(title: "Time & Date")
                    FilterButtonsView(
                        startDate: $viewModel.preferences.startDate,
                        endDate: $viewModel.preferences.endDate
                    )
                }
            
                heading(title: "Location")
                LocationPickerView(
                    selectedLocation: $viewModel.preferences.location
                )
                
                HStack {
                    heading(title: "Select price range")
                    Spacer()
                    Text("$\(Int(viewModel.preferences.minPrice ?? 0)) -")
                        .font(.Airbnb.medium(size: 16))
                        .foregroundStyle(.accentBlue)
                    Text("$\(Int(viewModel.preferences.maxPrice ?? 0))")
                        .font(.Airbnb.medium(size: 16))
                        .foregroundStyle(.accentBlue)
                }
                .padding(.vertical)
                
                RangeSlider(
                    minValue: Binding(
                        get: { viewModel.preferences.minPrice ?? 0 },
                        set: { viewModel.preferences.minPrice = $0 }
                    ),
                    maxValue: Binding(
                        get: { viewModel.preferences.maxPrice ?? 0 },
                        set: { viewModel.preferences.maxPrice = $0 }
                    ),
                        range: 0.0...200.0
                )
                
                Spacer()
                
                HStack {
                    Button(action: {
                        viewModel.reset()
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
                        viewModel.apply()
                        isPresented = false
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



