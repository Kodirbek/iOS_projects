
import Foundation

struct TheMetService {
  let baseURLString = "https://collectionapi.metmuseum.org/public/collection/v1/"
  let session = URLSession.shared
  let decoder = JSONDecoder()

  func getObjectIDs(from queryTerm: String) async throws -> ObjectIDs? {
    let objectIDs: ObjectIDs?

    guard var urlComponents = URLComponents(string: baseURLString + "search") else {
      return nil
    }
    let baseParams = ["hasImages": "true"]
    urlComponents.setQueryItems(with: baseParams)

    let term = queryTerm.isEmpty ? "the" : queryTerm
    // swiftlint:disable:next force_unwrapping
    urlComponents.queryItems! += [URLQueryItem(name: "q", value: term)]
    
    guard let queryURL = urlComponents.url else { return nil }
    let request = URLRequest(url: queryURL)

    let (data, response) = try await session.data(for: request)
    guard
      let response = response as? HTTPURLResponse,
      (200..<300).contains(response.statusCode)
    else {
      print(">>> getObjectIDs response outside bounds")
      return nil
    }

    do {
      objectIDs = try decoder.decode(ObjectIDs.self, from: data)
    } catch {
      print(error)
      return nil
    }
    return objectIDs
  }

  func getObject(from objectID: Int) async throws -> Object? {
    let object: Object?

    let objectURLString = baseURLString + "objects/\(objectID)"
    guard let objectURL = URL(string: objectURLString) else { return nil }
    let objectRequest = URLRequest(url: objectURL)

    let (data, response) = try await session.data(for: objectRequest)
    if let response = response as? HTTPURLResponse {
      let statusCode = response.statusCode
      if !(200..<300).contains(statusCode) {
        print(">>> getObject response \(statusCode) outside bounds")
        print(">>> \(objectURLString)")
        return nil
      }
    }

    do {
      object = try decoder.decode(Object.self, from: data)
    } catch {
      print(error)
      return nil
    }
    return object
  }
}
