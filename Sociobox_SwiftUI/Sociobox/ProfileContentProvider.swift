/// Copyright (c) 2024 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation
import SwiftUI
import Combine

protocol ProfileContentProviderProtocol: ObservableObject {
  var privacyLevel: PrivacyLevel { get }
  var canSendMessage: Bool { get }
  var canStartVideoChat: Bool { get }
  var photosView: AnyView { get }
  var feedView: AnyView { get }
  var friendsView: AnyView { get }
}

final class ProfileContentProvider<Store>: ProfileContentProviderProtocol
  where Store: PreferencesStoreProtocol {
  
  let privacyLevel: PrivacyLevel
  private let user: User
  private var store: Store
  private var cancellables: Set<AnyCancellable> = []

  init(
    privacyLevel: PrivacyLevel =
      DIContainer.shared.resolve(type: PrivacyLevel.self)!,
    user: User = DIContainer.shared.resolve(type: User.self)!,
    // 1
    store: Store = DIContainer.shared.resolve(type: Store.self)!
  ) {
    self.privacyLevel = privacyLevel
    self.user = user
    self.store = store

    // 2
    store.objectWillChange.sink { _ in
      self.objectWillChange.send()
    }
    .store(in: &cancellables)
  }



  var canSendMessage: Bool {
    privacyLevel >= store.messagePreference
  }

  var canStartVideoChat: Bool {
    privacyLevel >= store.videoCallsPreference
  }

  var photosView: AnyView {
    privacyLevel >= store.photosPreference ?
      AnyView(PhotosView(photos: user.photos)) :
      AnyView(EmptyView())
  }

  var feedView: AnyView {
    privacyLevel >= store.feedPreference ?
      AnyView(HistoryFeedView(posts: user.historyFeed)) :
      AnyView(EmptyView())
  }

  var friendsView: AnyView {
    privacyLevel >= store.friendsListPreference ?
      AnyView(UsersView(title: "Friends", users: user.friends)) :
      AnyView(EmptyView())
  }

}

