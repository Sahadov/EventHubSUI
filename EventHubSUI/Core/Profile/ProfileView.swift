

import SwiftUI


struct UserProfile {
    var name: String
    var avatarImageName: String?
    var about: String
}

struct ProfileView: View {
    @State private var selectedTab: TabBookmarksEnum = .profileView
    
    @ObservedObject var profileVM: ProfileViewModel
    
    @State var isEditingProfile: Bool = false
    @State var isLargeText: Bool = false
    @State var startEditAbout: Bool = false
    @State var startEditName: Bool = false
    @State var userAbout: String = ""
    @State var userName: String = ""
    
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: UI.spacingXL) {
                
                if let imageName = profileVM.user?.userIcon ?? User.MOCK_USER.userIcon {
//                    let _ = print(profileVM.user)
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill.questionmark")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 96, height: 96)
                        .foregroundStyle(.gray)
                }
                HStack(spacing: 8) {
                    if startEditName {
                        TextEditor(text: $userName)
                            .font(.Airbnb.book(size: 24))
                            .frame(height: 25)
                    } else {
                        Text(profileVM.user?.fullname ?? User.MOCK_USER.fullname)
                            .font(.Airbnb.book(size: 24))
                    }
                    if isEditingProfile {
                        Button(action: {
                            if startEditName {
                                startEditName.toggle()
                                if profileVM.user != nil {
                                    profileVM.user?.fullname = userName
                                }
                                
                            } else {
                                startEditName.toggle()
                            }
                        }) {
                            Image(systemName: "square.and.pencil")
                        }
                        .font(.Airbnb.medium(size: 20))
                        .foregroundStyle(.accentBlue)
                        .fontWeight(.medium)
                    }
                }
                if !isEditingProfile {
                    
                    Button(action: {
                        isEditingProfile = true
                    }) {
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
                
                VStack(alignment: .leading, spacing: 18) {
                    HStack(spacing: 8) {
                        Text("About me")
                            .font(.Airbnb.book(size: 20))
                            .frame(height: 65)
                        if isEditingProfile {
                            Button(action: {
                                if startEditAbout {
                                    startEditAbout.toggle()
                                    if profileVM.user != nil {
                                        profileVM.user?.about = userAbout
                                    }
                                    
                                } else {
                                    startEditAbout.toggle()
                                }
                            }) {
                                Image(systemName: "square.and.pencil")
                            }
                            .font(.Airbnb.medium(size: 20))
                            .foregroundStyle(.accentBlue)
                            .fontWeight(.medium)
                        }
                    }
                    if startEditAbout {
                        TextEditor(text: $userAbout)
                            .font(.Airbnb.book(size: 16))
                            .frame(height: 250)
                    } else {
                        Text((profileVM.user?.about ?? User.MOCK_USER.about) ?? User.MOCK_USER.about!)
                            .font(.Airbnb.book(size: 16))
                            .fixedSize(horizontal: false, vertical: true)
                            .lineLimit(isLargeText ? 25 : 3)
                        Button(isLargeText ? "Show less" : "Read More", action: {
                            isLargeText.toggle()
                        })
                        .font(.Airbnb.book(size: 16))
                        .foregroundStyle(.accentBlue)
                        .offset(y: -20)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        ChevronDownHint()
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                SignOutRow {
                    
                    profileVM.logout()
                }
                
                Spacer()
                
            }
            .padding(.horizontal, UI.pagePadding)
            .padding(.bottom, UI.spacingXL)
        }
        
        .onAppear() {
            Task {
                await    profileVM.authManager.fetchUser()
                self.userAbout = profileVM.user?.about ?? User.MOCK_USER.about!
            }
        }
        
        .onTapGesture {
            if startEditName {
                startEditName.toggle()
                if profileVM.user != nil {
                    profileVM.user?.about = userName
                }
            }
            if startEditAbout {
                startEditAbout.toggle()
                if profileVM.user != nil {
                    profileVM.user?.fullname = userAbout
                }
                
            }
            if isEditingProfile {
                
                profileVM.updateUser()
                isEditingProfile.toggle()
                
            }
        }
        
        .alert(profileVM.errorTitle, isPresented: $profileVM.isShowingError) {} message: {
            Text(profileVM.errorMessage)
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
    ProfileView(profileVM: ProfileViewModel(authManager: AuthManager(), router: Router()))
}
