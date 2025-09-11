import SwiftUI

struct EventInfoView: View {
    let firstText: String
    let secondText: String
    let iconName: String
    
    init(firstText: String, secondText: String, iconName: String) {
        self.firstText = firstText
        self.secondText = secondText
        self.iconName = iconName
    }

    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Image(iconName)
                Rectangle()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.accentBlue.opacity(0.1))
                    .cornerRadius(12)
            }
            VStack(alignment: .leading, spacing: 1) {
                Text(firstText)
                    .font(.system(size: 16))
                    .frame(height: 34)
                Text(secondText)
                    .foregroundStyle(.gray)
                    .font(.Airbnb.book(size: 12))
            }
        }
    }
}
