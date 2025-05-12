import SwiftUI

struct AwardGrid: View {
  var title: String
  @Binding var selected: AwardInformation?
  var awards: [AwardInformation]
  var namespace: Namespace.ID

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
        AwardCardView(award: award)
          .foregroundColor(.black)
          .aspectRatio(0.67, contentMode: .fit)
          .onTapGesture {
            withAnimation {
              selected = award
            }
          }
          .matchedGeometryEffect(
            id: award.hashValue,
            in: namespace,
            anchor: .topLeading
          )
      }
    }
  }
}

#Preview {
  @Previewable @Namespace var namespace
  
  AwardGrid(
    title: "Test",
    selected: .constant(nil),
    awards: AppEnvironment().awardList,
    namespace: namespace
  )
}
