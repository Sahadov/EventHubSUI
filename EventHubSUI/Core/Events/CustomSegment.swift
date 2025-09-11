//
//  CustomSegment.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 10/09/2025.
//

import SwiftUI

struct CustomSegment: View {
    let title: String
    let tag: Int
    @Binding var selection: Int
    var animation: Namespace.ID
    
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                selection = tag
            }
        } label: {
            ZStack {
                if selection == tag {
                    Capsule()
                        .fill(Color.white)
                        .matchedGeometryEffect(id: "TAB_BACKGROUND", in: animation)
                        .frame(height: 36)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 5)
                }
                
                Text(title)
                    .font(.Airbnb.light(size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(selection == tag ? .accentBlue : Color.gray)
                    .frame(maxWidth: .infinity, minHeight: 36)
            }
        }
        .buttonStyle(.plain)
    }
}

