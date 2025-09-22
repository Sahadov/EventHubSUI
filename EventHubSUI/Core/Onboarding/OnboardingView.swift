//
//  OnboardingView.swift
//  EventHubSUI
//
//  Created by Dmitry Volkov on 07/09/2025.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var shouldShowOnboarding: Bool
    @State private var currentPage = 0
    
    let onboardingData = [
        OnboardingItem(
            image: "onboarding1",
            title: "Explore Upcoming & Nearby Events",
            subtitle: "Find new events happening around you and never miss out."
        ),
        OnboardingItem(
            image: "onboarding2",
            title: "Modern Events Calendar",
            subtitle: "Easily track your favorite events and plan ahead."
        ),
        OnboardingItem(
            image: "onboarding3",
            title: "Discover Events on the Map",
            subtitle: "Locate more events and activities nearby with a map view."
        )
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    VStack(spacing: 0) {
                        VStack {
                            Spacer()
                            Image(onboardingData[index].image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: UIScreen.main.bounds.height / 2.0)
                                .clipped()
                        }
                        .padding(.top, 50)
                        
                        ZStack(alignment: .top) {
                            Color.accentBlue
                                .cornerRadius(30, corners: [.topLeft, .topRight])
                                .ignoresSafeArea()
                            
                            VStack(alignment: .center, spacing: 20) {
                                Text(onboardingData[index].title)
                                    .multilineTextAlignment(.center)
                                    .font(.Airbnb.extraBold(size: 30))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                
                                Text(onboardingData[index].subtitle)
                                    .multilineTextAlignment(.center)
                                    .font(.Airbnb.light(size: 16))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30)
                                
                                HStack {
                                    Button(action: {
                                        // Skip action
                                        OnboardingManager.completeOnboarding()
                                        shouldShowOnboarding = false
                                        
                                    }) {
                                        Text("Skip")
                                            .foregroundColor(.white.opacity(0.7))
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 1)) {
                                            if currentPage < onboardingData.count - 1 {
                                                currentPage += 1
                                            } else {
                                                OnboardingManager.completeOnboarding()
                                                shouldShowOnboarding = false
                                            }
                                        }
                                    }) {
                                        Text("Next")
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(.horizontal, 40)
                                .padding(.top, 40)
                            }
                            .padding(.top, 80)
    
                        }
                    }
                    .tag(index)
                    .ignoresSafeArea()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
        }
    }
}

// Модель для экранов
struct OnboardingItem {
    let image: String
    let title: String
    let subtitle: String
}

// Extension для закругления только верхних углов
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


#Preview {
    OnboardingView(shouldShowOnboarding: .constant(true))
}
