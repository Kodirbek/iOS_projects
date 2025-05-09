import SwiftUI

struct AwardGrid: View {
  var title: String
  var awards: [AwardInformation]

  var body: some View {
    Section(
      header: Text(title)
        .frame(maxWidth: .infinity)
        .font(.title)
        .foregroundColor(.white)
        .background(
          .ultraThinMaterial,
          in: RoundedRectangle(cornerRadius: 10)
        )
    ) {
      ForEach(awards, id: \.self) { award in
        NavigationLink(destination: AwardDetails(award: award)) {
          AwardCardView(award: award)
            .foregroundColor(.black)
            .aspectRatio(0.67, contentMode: .fit)
        }
      }
    }
  }
}

#Preview {
  AwardGrid(
    title: "Test",
    awards: AppEnvironment().awardList
  )
}
