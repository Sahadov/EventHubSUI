//
//  WebViewScreen.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 15.09.2025.
//

import SwiftUI


struct EventWebView: View {
    let urlString: String

    var body: some View {
        if let url = URL(string: urlString) {
            WebView(url: url)
                .navigationTitle("Event")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            Text("Invalid URL")
                .foregroundColor(.red)
        }
    }
}

#Preview {
    EventWebView(urlString: "https://kudago.com/msk/place/stanislavskymusic/")
}
