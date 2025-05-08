
import SwiftUI

@main
struct TheMetApp: App {
  @State var store = TheMetStore()
  
  var body: some Scene {
    WindowGroup {
      ContentView(store: store)
    }
  }
}
