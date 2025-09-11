

import SwiftUI


struct UserProfile {
    var name: String
    var avatarImageName: String?
    var about: String
}

struct ProfileView: View {
    @State private var selectedTab: TabBookmarksEnum = .profileView
    
    private let profile = UserProfile(
        name: "Ashfak Sayem",
        avatarImageName: "avatarAshfak",
        about: """
Enjoy your favorite dish and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.
"""
    )

    var body: some View {
        ScrollView {
            VStack(spacing: UI.spacingXL) {
                AvatarAndName(profile: profile)

                EditProfileButton {
                    // TODO: Hook to edit action / navigation
                }

                AboutSection(
                    title: "About Me",
                    text: profile.about,
                    onReadMore: {
                        // TODO: show full text / expand
                    },
                    onEdit: {
                        // TODO: open editor for About
                    }
                )
                Spacer()

                SignOutRow {
                    // TODO: sign out handler
                }
                
                Spacer()
               
            }
            .padding(.horizontal, UI.pagePadding)
            .padding(.bottom, UI.spacingXL)
        }
        .navigationBarHidden(true)
        .safeAreaInset(edge: .top) {
            CustomNavBar(title: "Profile")
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}


private struct AvatarAndName: View {
    let profile: UserProfile

    var body: some View {
        VStack(spacing: 12) {
            if let imageName = profile.avatarImageName {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 96, height: 96)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 96, height: 96)
                    .foregroundStyle(.secondary)
            }
            
            Text(profile.name)
                .font(.Airbnb.book(size: 24))
        }
    }
}


private struct EditProfileButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: "square.and.pencil")
                    .font(.Airbnb.medium(size: 22))
                    .foregroundStyle(.accentBlue)
                    .fontWeight(.medium)
                   
                Text("Edit Profile")
                    .font(.Airbnb.book(size: 16))
                    .foregroundStyle(.accentBlue)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 18)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.accentBlue, lineWidth: 1.5)
            )

        }
    }
}


private struct AboutSection: View {
    let title: String
    let text: String
    let onReadMore: () -> Void
    let onEdit: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 8) {
                Text(title)
                    .font(.Airbnb.book(size: 20))
                    .frame(height: 65)
                Button(action: onEdit) {
                    Image(systemName: "square.and.pencil")
                }
                .font(.Airbnb.medium(size: 20))
                .foregroundStyle(.accentBlue)
                .fontWeight(.medium)
            }
            Text(text)
                .font(.Airbnb.book(size: 16))
                .fixedSize(horizontal: false, vertical: true)
            Button("Read More", action: onReadMore)
                .font(.Airbnb.book(size: 16))
                .foregroundStyle(.accentBlue)
            Spacer()
            Spacer()
            HStack {
                Spacer()
                ChevronDownHint()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


private struct ChevronDownHint: View {
    var body: some View {
        Image(systemName: "chevron.down")
            .font(.Airbnb.bold(size: 10))
            .foregroundStyle(.accentBlue)
    }
}


private struct SignOutRow: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Spacer()
                Image(systemName: "rectangle.portrait.and.arrow.right")
                    .font(.title3)
                Text("Sign Out")
                    .font(.body)
                Spacer()
            }
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .foregroundColor(.primary)
    }
}


private enum UI {
    static let pagePadding: CGFloat = 24
    static let spacingL: CGFloat = 16
    static let spacingXL: CGFloat = 24
}


#Preview {
    ProfileView()
}
