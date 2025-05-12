import SwiftUI

struct AwardsView: View {
  @EnvironmentObject var flightNavigation: AppEnvironment
  @State var selectedAward: AwardInformation?
  var awardArray: [AwardInformation] {
    flightNavigation.awardList
  }
  
  var awardColumns: [GridItem] {
    [GridItem(.adaptive(minimum: 150, maximum: 170))]
  }
  
  var activeAwards: [AwardInformation] {
    awardArray.filter { $0.awarded }
  }
  
  var inactiveAwards: [AwardInformation] {
    awardArray.filter { !$0.awarded }
  }
  
  var body: some View {
    ZStack {
      if let award = selectedAward {
        AwardDetails(award: award)
          .background(Color.white)
          .shadow(radius: 5.0)
          .clipShape(RoundedRectangle(cornerRadius: 20.0))
          .onTapGesture {
            withAnimation {
              selectedAward = nil
            }
          }
          .navigationTitle(award.title)
      } else {
        ScrollView {
          LazyVGrid(columns: awardColumns) {
            AwardGrid(
              title: "Awarded",
              selected: $selectedAward,
              awards: activeAwards
            )
            AwardGrid(
              title: "Not Awarded",
              selected: $selectedAward,
              awards: inactiveAwards
            )
          }
        }
        .navigationTitle("Your Awards")
      }
    }
    .navigationTitle("Your Awards")
    .background(
      Image("background-view")
        .resizable()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    )
  }
}


#Preview {
  NavigationStack {
    AwardsView()
  }
  .environmentObject(AppEnvironment())
}
