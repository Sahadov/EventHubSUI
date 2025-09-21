//
//  FavoritesView.swift
//  EventHubSUI
//
//  Created by Sergey on 08.09.2025.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject var vm: FavoritesViewModel
    @State private var isSearching = false
    @FocusState private var searchFocused: Bool
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.filteredFavorites.isEmpty {
                    EmptyFavoritesView()
                        .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(vm.filteredFavorites) { event in
                                Button {
                                    vm.goToDetailedView(event: event)
                                } label: {
                                    EventCard(type: .isFavourite, event: event, onCardTapped:  {
                                        withAnimation(.snappy) {
                                            vm.toggleFavorite(event)
                                        }
                                    })
                                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                                }
                                .buttonStyle(.plain)
                                .padding(.horizontal, 16)
                            }
                        }
                        .padding(.vertical, 12)
                    }
                    .background(Color(UIColor.systemGroupedBackground).ignoresSafeArea())
                    .refreshable {
                        vm.loadFavorites()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .principal) {
                    if isSearching {
                        TextField("Search favorites", text: $vm.query)
                            .textFieldStyle(.roundedBorder)
                            .frame(maxWidth: .infinity)
                            .submitLabel(.search)
                            .focused($searchFocused)
                            .onAppear { searchFocused = true }
                    } else {
                        Text("Favorites")
                            .font(.Airbnb.book(size: 24))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    if isSearching {
                        Button("Cancel") {
                            vm.query = ""
                            isSearching = false
                            searchFocused = false
                        }
                    } else {
                        Button {
                            withAnimation { isSearching = true }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                        }
                        .accessibilityLabel("Search")
                    }
                }
            }
        }
        .onAppear{ vm.loadFavorites() }
    }
}

