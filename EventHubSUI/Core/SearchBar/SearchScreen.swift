//
//  SearchScreen.swift
//  EventHubSUI
//
//  Created by Артур  Арсланов on 16.09.2025.
//
import SwiftUI

struct SearchScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: SearchViewModel

    init(events: [Event]) {
        _vm = StateObject(wrappedValue: SearchViewModel(events: events))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                ExploreSearchBar(text: $vm.query, placeholder: "Search...") {
                    // открыть фильтры
                }
                .padding(.top, 8)

                if vm.isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()
                } else if let err = vm.loadError {
                    Spacer()
                    VStack(spacing: 8) {
                        Text("Failed to load").font(.headline)
                        Text(err).font(.footnote).foregroundStyle(.secondary)
                        Button("Retry") {
                            Task { await vm.fetchEvents() }
                        }
                    }
                    Spacer()
                } else if vm.results.isEmpty {
                    Spacer()
                    Text("NO RESULTS")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(vm.results) { event in
                                EventCard(type: .search, event: event)
                                    .padding(.horizontal, 16)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .refreshable { await vm.fetchEvents() }
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { dismiss() } label: {
                        Image(systemName: "arrow.left").font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Search").font(.system(size: 20, weight: .semibold))
                }
            }
            .onAppear { vm.applyFilter() }
            .onChange(of: vm.query) { _ in vm.applyFilter() }
            .task { await vm.fetchEvents() }
        }
    }
}

#Preview {
    SearchScreen(events: [])
}
