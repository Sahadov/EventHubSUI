import SwiftUI

struct EventInfoView: View {
    let firstText: String
    let secondText: String
    let iconName: String
    
    var body: some View {
        HStack(spacing: 14) {
            ZStack {
                Rectangle()
                    .frame(width: 48, height: 48)
                    .foregroundStyle(.accentBlue.opacity(0.1))
                    .cornerRadius(12)
                Image(iconName)
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

#Preview {
    VStack {
        EventInfoView(firstText: "14 December, 2021",
                      secondText: "Tuesday, 4:00PM - 9:00PM",
                      iconName: "blueCalendar")
        
        EventInfoView(firstText: "Gala Convention Center",
                      secondText: "39 Guild Street London, UK",
                      iconName: "bluePin")
        
        EventInfoView(firstText: "14 December, 2021",
                      secondText: "Tuesday, 4:00PM - 9:00PM",
                      iconName: "Organizer")
    }
}
