//
//  ShareBottomSheet.swift
//  EventHubSUI
//
//

import SwiftUI

struct ShareBottomSheet: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Share with friends")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(.customTitle)
                Spacer()
            }
            .padding(.top, 35)
            .padding(.leading, 24)
            .padding(.bottom, 24)
            
            HStack(spacing: 0) {
                ForEach(0..<4) { index in
                    IconButton(
                        imageName: ["link", "whatsApp", "facebook", "messenger"][index],
                        name: ["Copy Link", "WhatsApp", "Facebook", "Messenger"][index]
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 30)
            
            HStack(spacing: 0) {
                ForEach(0..<4) { index in
                    IconButton(
                        imageName: ["twitter", "instagram", "skype", "messages"][index],
                        name: ["Twitter", "Instagram", "Skype", "Message"][index]
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 30)
            
            Spacer()
            
            Button("CANCEL") {
                dismiss()
            }
            .font(.system(size: 16))
            .kerning(0.1)
            .foregroundColor(.customGray)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(15)
            .frame(height: 58)
            .padding(.horizontal, 52)
        }
        .padding(.horizontal)
    }
}

struct IconButton: View {
    let imageName: String
    let name: String
    
    var body: some View {
        Button(action: {
            print("Нажата кнопка: \(name)")
        }) {
            VStack(spacing: 11) {
                Image(imageName)
                    .frame(width: 40, height: 40)
                
                Text(name)
                    .font(.system(size: 13))
                    .foregroundColor(.customPurpleGray)
            }
        }
    }
}

struct ContentView: View {
    @State private var showSheet = false
    
    var body: some View {
        Button("Show Bottom Sheet") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            ShareBottomSheet()
                .presentationDetents([.height(359)])
                .presentationCornerRadius(38)
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
}
