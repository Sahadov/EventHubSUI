//
//  SeeAllCell.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI

struct SeeAllCell: View {
    let event: Event
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // Левая картинка
            SeeAllImage(event: event)
                .frame(width: screenWidth * 0.28, height: screenWidth * 0.30)
                .padding(20)

            SeeAllDetail(event: event)
                .frame(maxWidth: .infinity, alignment: .leading)
            
        }

        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 16) // отступ от краёв экрана
        .padding(.top, 12) // отступ сверху всей карточки
    }
}



#Preview {
    SeeAllCell(event: .mockConcert)
}
