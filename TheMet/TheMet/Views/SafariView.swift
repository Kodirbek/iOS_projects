
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
  let url: URL

  func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
    return SFSafariViewController(url: url)
  }

  func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}

#Preview {
  // swiftlint:disable:next force_unwrapping
  SafariView(url: URL(string: "https://www.metmuseum.org/art/collection/search/437092")!)
}
