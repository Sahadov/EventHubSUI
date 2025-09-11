//
//  CustomSIButton.swift
//  EventHubSUI
//
//  Created by Sergey on 10.09.2025.
//

import SwiftUI

struct CustomSIButton: View {
    
    var buttonLableText: String
    var buttonCornerRadius: CGFloat = 15
    var buttonBackgroundColor: Color = .accentBlue
    var buttonHeight: CGFloat = 58
    var buttonFontSize: CGFloat = 16
    
    var buttonTapAction: (() -> Void)?
    
    var body: some View {
        Button {
            buttonTapAction?()
        } label: {
            RoundedRectangle(cornerRadius: buttonCornerRadius)
                .fill(buttonBackgroundColor)
                .frame(width: 271, height: buttonHeight)
                .overlay(alignment: .center) {
                    ZStack {
                        Text(buttonLableText)
                            .font(.system(size: buttonFontSize, weight: .semibold, design: .default))
                            .kerning(1)
                        Image(.rightArrow)
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .padding(.vertical, 14)
                            .offset(x: 110)
                    }
                    .foregroundStyle(.white)
                    
                }
        }
    }
}

#Preview {
    CustomSIButton(buttonLableText: "SIGN IN")
}
