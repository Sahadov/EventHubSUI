//
//  ShareBottomSheet.swift
//  EventHubSUI
//
//

import SwiftUI
import LinkPresentation

struct ShareBottomSheet: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showShareSheet = false
    @State private var showCopiedAlert = false
    
    let shareURL = URL(string: "https://your-app.com/event")! // тут должна быть ссылочка ивента
    let shareMessage = "Share with friends!"
    
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
                IconButton(
                    imageName: "link",
                    name: "Copy Link",
                    action: copyToClipboard
                )
                .frame(maxWidth: .infinity)
                
                IconButton(
                    imageName: "whatsApp",
                    name: "WhatsApp",
                    action: { shareToApp("whatsapp://") }
                )
                .frame(maxWidth: .infinity)
                
                IconButton(
                    imageName: "facebook",
                    name: "Facebook",
                    action: { shareToApp("fb://") }
                )
                .frame(maxWidth: .infinity)
                
                IconButton(
                    imageName: "messenger",
                    name: "Messenger",
                    action: { shareToApp("fb-messenger://") }
                )
                .frame(maxWidth: .infinity)
            }
            .padding(.bottom, 30)
            
            HStack(spacing: 0) {
                IconButton(
                    imageName: "twitter",
                    name: "Twitter",
                    action: { shareToApp("twitter://") }
                )
                .frame(maxWidth: .infinity)
                
                IconButton(
                    imageName: "instagram",
                    name: "Instagram",
                    action: { shareToApp("instagram://") }
                )
                .frame(maxWidth: .infinity)
                
                IconButton(
                    imageName: "skype",
                    name: "Skype",
                    action: { shareToApp("skype://") }
                )
                .frame(maxWidth: .infinity)
                
                IconButton(
                    imageName: "messages",
                    name: "Message",
                    action: { showNativeShareSheet() }
                )
                .frame(maxWidth: .infinity)
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
        .sheet(isPresented: $showShareSheet) {
            NativeShareSheet(items: [shareMessage, shareURL])
        }
        .alert("Link Copied!", isPresented: $showCopiedAlert) {
            Button("OK", role: .cancel) {}
        }
    }
    
    private func copyToClipboard() {
        UIPasteboard.general.string = shareURL.absoluteString
        showCopiedAlert = true
    }
    
    private func shareToApp(_ scheme: String) {
        guard let appURL = URL(string: scheme) else { return }
        
        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            showNativeShareSheet()
        }
    }
    
    private func showNativeShareSheet() {
        showShareSheet = true
    }
}

struct IconButton: View {
    let imageName: String
    let name: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
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

struct NativeShareSheet: UIViewControllerRepresentable {
    var items: [Any]
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview {
    ShareBottomSheet()
}
