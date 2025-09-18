//
//  RangeSlider.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 17/09/2025.
//

import SwiftUI

struct RangeSlider: View {
    @Binding var minValue: Double
    @Binding var maxValue: Double
    let range: ClosedRange<Double>
    
    let numberOfBars = 40
    @State private var barHeights: [CGFloat] = []
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            let height = geo.size.height
            let sliderY = height / 2
            
            ZStack {
                // Серый фон трека
                Rectangle()
                    .fill(Color.gray.opacity(0.4))
                    .frame(height: 4)
                    .position(x: width / 2, y: sliderY)
                
                // Синий трек выбранного диапазона
                Rectangle()
                    .fill(Color.accentColor)
                    .frame(
                        width: CGFloat((maxValue - minValue) / (range.upperBound - range.lowerBound)) * width,
                        height: 4
                    )
                    .position(
                        x: (CGFloat((minValue - range.lowerBound) / (range.upperBound - range.lowerBound)) * width)
                          + (CGFloat((maxValue - minValue) / (range.upperBound - range.lowerBound)) * width) / 2,
                        y: sliderY
                    )
                
                // Серые столбики вверх в выбранном диапазоне
                ForEach(0..<numberOfBars, id: \.self) { i in
                    let fraction = Double(i) / Double(numberOfBars)
                    let value = range.lowerBound + fraction * (range.upperBound - range.lowerBound)
                    if value >= minValue && value <= maxValue {
                        let barX = CGFloat(fraction) * width
                        let barHeight = barHeights.indices.contains(i) ? barHeights[i] : 30
                        
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.gray.opacity(0.5))
                            .frame(width: 4, height: barHeight)
                            .position(x: barX, y: sliderY - barHeight / 2)
                    }
                }
                
                // Левая ручка
                RangeHandle()
                    .position(
                        x: CGFloat((minValue - range.lowerBound) / (range.upperBound - range.lowerBound)) * width,
                        y: sliderY
                    )
                    .gesture(
                        DragGesture().onChanged { value in
                            let newValue = Double(value.location.x / width) * (range.upperBound - range.lowerBound) + range.lowerBound
                            minValue = min(max(newValue, range.lowerBound), maxValue)
                        }
                    )
                
                // Правая ручка
                RangeHandle()
                    .position(
                        x: CGFloat((maxValue - range.lowerBound) / (range.upperBound - range.lowerBound)) * width,
                        y: sliderY
                    )
                    .gesture(
                        DragGesture().onChanged { value in
                            let newValue = Double(value.location.x / width) * (range.upperBound - range.lowerBound) + range.lowerBound
                            maxValue = max(min(newValue, range.upperBound), minValue)
                        }
                    )
            }
            .onAppear {
                if barHeights.isEmpty {
                    barHeights = (0..<numberOfBars).map { _ in CGFloat.random(in: 20...60) }
                }
            }
        }
        .frame(height: 120)
    }
}

