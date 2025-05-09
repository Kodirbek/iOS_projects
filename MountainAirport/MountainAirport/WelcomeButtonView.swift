import SwiftUI

struct WelcomeButtonView: View {
  var title: String
  var subTitle: String
  var imageName: String
  var imageAngle: Double = 0.0

  var body: some View {
    HStack {
      Image(systemName: imageName)
        .resizable()
        .frame(width: 30, height: 30)
        .padding(10)
        .background(
          Circle()
            .foregroundColor(.white)
        )
        .padding(15.0)
        .rotationEffect(.degrees(imageAngle))
      VStack(alignment: .leading) {
        Text(title)
          .font(.title2)
        Text(subTitle)
          .font(.subheadline)
      }
      .foregroundColor(.white)
      .padding([.top, .bottom], 15.0)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(
      Image("link-pattern")
        .resizable()
        .clipped()
    )
    .shadow(radius: 10)
  }
}

#Preview {
  WelcomeButtonView(
    title: "Flight Status",
    subTitle: "Departure and Arrival Information",
    imageName: "airplane",
    imageAngle: -45.0
  )
}
