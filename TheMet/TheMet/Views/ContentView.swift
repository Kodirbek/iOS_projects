
import SwiftUI

struct ContentView: View {
  @State var objects: [Object] = []
  private let service = TheMetService()
  let maxIndex = 20

  @State private var query = "rhino"
  @State private var showQueryField = false
  @State private var fetchObjectsTask: Task<Void, Error>?

  func fetchObjects(for queryTerm: String) async throws {
    if let objectIDs = try await service.getObjectIDs(from: queryTerm) {
      for (index, objectID) in objectIDs.objectIDs.enumerated()
      where index < maxIndex {
        if let object = try await service.getObject(from: objectID) {
          await MainActor.run {
            objects.append(object)
          }
        }
      }
    }
  }

  var body: some View {
    NavigationStack {
      VStack {
        Text("You searched for '\(query)'")
          .padding(5)
          .background(Color.metForeground)
          .cornerRadius(10)
        List(objects) { object in
          if !object.isPublicDomain,
            let url = URL(string: object.objectURL) {
            NavigationLink(value: url) {
              WebIndicatorView(title: object.title)
            }
            .listRowBackground(Color.metBackground)
            .foregroundColor(.white)
          } else {
            NavigationLink(object.title) {
              ObjectView(object: object)
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
          .foregroundColor(Color.metBackground)
          .padding(.horizontal)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.metBackground, lineWidth: 2))
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
                  objects = []
                  try await fetchObjects(for: query)
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
        if objects.isEmpty { ProgressView() }
      }
    }
    .task {
      do {
        try await fetchObjects(for: query)
      } catch {}
    }
  }
}

#Preview {
  ContentView()
}
