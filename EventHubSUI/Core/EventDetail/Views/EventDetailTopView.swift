//
//  EventDetailTopView.swift
//  EventHubSUI
//
//  Created by Alexander Abanshin on 21.09.2025.
//

import SwiftUI

struct EventDetailTopView: View {
    private let screenWidth = UIScreen.main.bounds.width
    let event: Event
    @Binding var isBookmarked: Bool
    
    var onBookmarkTapped: (() -> Void)? = nil
    var onShareTapped: (() -> Void)? = nil
    
    var body: some View {
        ImageView(event: event)
            .overlay(
                ZStack {
                    bookmarkView
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(.top, screenWidth * 0.25)
                        .padding(.trailing, screenWidth * 0.05)
                    
                    shareView
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                        .padding(.bottom, screenWidth * 0.05)
                        .padding(.trailing, screenWidth * 0.05)
                }
            )
    }
    
    // MARK: - Bookmark View
    var bookmarkView: some View {
        Button {
            if RealmManager.shared.exists(type: RealmEvent.self, forPrimaryKey: event.id) {
                // Уже в закладках → удаляем
                if let object = RealmManager.shared.fetch(RealmEvent.self)
                    .filter("id == %@", event.id).first {
                    RealmManager.shared.delete(object)
                }
            } else {
                // Не в закладках → добавляем
                let realmEvent = RealmEvent(from: event)
                RealmManager.shared.save(realmEvent)
            }
            isBookmarked.toggle()
            onBookmarkTapped?()
        } label: {
            Image(isBookmarked ? "bookmark2" : "bookmark")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.04, height: screenWidth * 0.04)
                .padding(screenWidth * 0.019)
                .background(
                    RoundedRectangle(cornerRadius: screenWidth * 0.014)
                        .fill(Color.white.opacity(0.8))
                )
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Share View
    var shareView: some View {
        Button {
            onShareTapped?()
        } label: {
            Image(systemName: "square.and.arrow.up")
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.04, height: screenWidth * 0.04)
                .padding(screenWidth * 0.019)
                .background(
                    RoundedRectangle(cornerRadius: screenWidth * 0.014)
                        .fill(Color.white.opacity(0.8))
                )
        }
        .buttonStyle(.plain)
    }
}


// MARK: - ImageView
private struct ImageView: View {
    let event: Event
    
    var body: some View {
        AsyncImage(url: URL(string: event.displayImageURL ??
                                  "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?w=144")) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: UIScreen.main.bounds.width, height: 244)
                    .background(Color.gray)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: 244)
                    .clipped()
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: 244)
                    .background(Color.gray)
                    .foregroundColor(.white)
            @unknown default:
                EmptyView()
            }
        }
        .ignoresSafeArea(edges: .top)
    }
}


// MARK: - Stateful Preview Wrapper
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content

    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}

#Preview {
    StatefulPreviewWrapper(true) { isBookmarked in
        EventDetailTopView(event: Event.mockToday, isBookmarked: isBookmarked)
    }
}


