
import SwiftUI

struct ContentView: View {
  @Bindable var store: TheMetStore
  @State private var query = "rhino"
  @State private var showQueryField = false
  @State private var fetchObjectsTask: Task<Void, Error>?

  var body: some View {
    NavigationStack {
      VStack {
        Text("You searched for '\(query)'")
          .padding(5)
          .background(.metForeground)
          .cornerRadius(10)
        List($store.objects) { $object in
          if !object.isPublicDomain,
            let url = URL(string: object.objectURL) {
            NavigationLink(value: url) {
              WebIndicatorView(title: object.title)
            }
            .listRowBackground(Color.metBackground)
            .foregroundColor(.white)
          } else {
            NavigationLink(object.title) {
              ObjectView(object: $object)
            }
            .listRowBackground(Color.metForeground)
          }
        }
        .navigationTitle("The Met")
        .toolbar {
          Button("Search the Met") {
            query = ""
            showQueryField = true
          }
          .foregroundColor(.metBackground)
          .padding(.horizontal)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .stroke(.metBackground, lineWidth: 2))
        }
        .alert(
          "Search the Met",
          isPresented: $showQueryField,
          actions: {
            TextField("Search the Met", text: $query)
            Button("Search") {
              fetchObjectsTask?.cancel()
              fetchObjectsTask = Task {
                do {
                  store.objects = []
                  try await store.fetchObjects(for: query)
                } catch {}
              }
            }
          })
        .navigationDestination(for: URL.self) { url in
          SafariView(url: url)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea()
        }
      }
      .overlay {
        if store.objects.isEmpty { ProgressView() }
      }
    }
    .task {
      do {
        try await store.fetchObjects(for: query)
      } catch {}
    }
  }
}

#Preview {
  ContentView(store: MockMetStore())
}
