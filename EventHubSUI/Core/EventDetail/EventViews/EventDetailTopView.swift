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
                        .padding(.top, screenWidth * 0.25)
                        .padding(.trailing, screenWidth * 0.05)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    
                    shareView
                        .padding(.bottom, screenWidth * 0.05)
                        .padding(.trailing, screenWidth * 0.05)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
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
            
        }
        label: {
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
            
            print("TaPed2")
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


private struct ImageView: View {
    let event: Event
    
    var body: some View {
        AsyncImage(url: URL(string: event.displayImageURL ??
                                  "https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2?w=144")) { phase in
                  switch phase {
                  case .empty:
                      ProgressView()
                          .frame(height: 244)
                          .frame(maxWidth: .infinity)
                          .background(Color.gray)
                  case .success(let image):
                      image
                          .resizable()
                          .scaledToFill()
                          .frame(height: 244)
                          .frame(maxWidth: .infinity)
                          .clipped()
                  case .failure:
                      Image(systemName: "photo")
                          .resizable()
                          .scaledToFit()
                          .frame(height: 244)
                          .frame(maxWidth: .infinity)
                          .background(Color.gray)
                          .foregroundColor(.white)
                  @unknown default:
                      EmptyView()
                  }
              }
              .ignoresSafeArea(edges: .top)
          }
    
    
}


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
