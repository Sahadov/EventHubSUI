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
    
    init(events: [Event], router: Router) {
        _vm = StateObject(wrappedValue: SearchViewModel(events: events, router: router))
    }
    
    var body: some View {
        VStack(spacing: 12) {
            ExploreSearchBar(
                text: $vm.query,
                iconColor: .accentBlue,
                placeholder: "Search...",
                onRightButtonTap: { vm.showFilterSheet = true }
            )
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
                            EventCard(
                                type: .search,
                                event: event,
                                onCardTapped: {
                                    vm.goToEventDetails(event: event)
                                }
                            )
                            .padding(.horizontal, 16)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .refreshable { await vm.fetchEvents() }
            }
        }
        .onAppear { vm.applyFilter() }
        .onChange(of: vm.query) { _ in vm.applyFilter() }
        .task { await vm.fetchEvents() }
        .searchNavigationStyle(title: "Search") { dismiss() }
        .sheet(isPresented: $vm.showFilterSheet) {
            FilterView(isPresented: $vm.showFilterSheet)
        }
    }
}



