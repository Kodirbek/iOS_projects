import SwiftUI

struct AwardDetails: View {
  var award: AwardInformation

  func imageSize(proxy: GeometryProxy) -> Double {
    let size = min(proxy.size.width, proxy.size.height)
    return size * 0.8
  }

  var body: some View {
    VStack(alignment: .center) {
      Image(award.imageName)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .padding()
      Text(award.title)
        .font(.title)
        .padding()
      Text(award.description)
        .font(.body)
        .padding()
      AwardStars(stars: award.stars)
        .foregroundColor(.yellow)
        .shadow(color: .black, radius: 5)
      Spacer()
    }.padding()
    .opacity(award.awarded ? 1.0 : 0.4)
    .saturation(award.awarded ? 1 : 0)
  }
}

#Preview("Awarded View") {
  let award = AwardInformation(
    imageName: "first-visit-award",
    title: "First Visit",
    description: "Awarded the first time you open the app while at the airport.",
    awarded: true,
    stars: 1
  )

  return AwardDetails(award: award)
}

#Preview("Unawarded View") {
  let award = AwardInformation(
    imageName: "rainy-day-award",
    title: "Rainy Day",
    description: "Your flight was delayed because of weather.",
    awarded: false,
    stars: 3
  )

  return AwardDetails(award: award)
}
