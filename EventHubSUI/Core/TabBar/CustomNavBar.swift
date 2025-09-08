//
//  CustomNavBar.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct CustomNavBar: View {
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal)
                .padding(.top, 10)
            
            Spacer()
        }
        .frame(height: 50)
        .background(Color(.systemBackground))
    }
}

#Preview {
    CustomNavBar(title: "Example Title")
}

