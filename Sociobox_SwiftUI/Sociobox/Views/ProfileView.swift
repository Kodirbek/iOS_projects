/// Copyright (c) 2020 Razeware LLC
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
// swiftlint:disable multiple_closures_with_trailing_closure

import SwiftUI

struct ProfileView: View {
  private let privacyLevel = PrivacyLevel.friend
  private let user: User = Mock.user()

  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: true) {
        VStack {
          ProfileHeaderView(
            user: user,
            canSendMessage: privacyLevel == .friend,
            canStartVideoChat: privacyLevel == .friend
          )
          if privacyLevel == .friend {
            UsersView(title: "Friends", users: user.friends)
            PhotosView(photos: user.photos)
            HistoryFeedView(posts: user.historyFeed)
          } else {
            RestrictedAccessView()
          }
        }
      }
      .navigationTitle("Profile")
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}

// MARK: - Profile views

struct PhotosView: View {
  private let photos: [String]

  init(photos: [String]) {
    self.photos = photos
  }

  var body: some View {
    VStack {
      Text("Recent photos").font(.title2)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(photos, id: \.self) { url in
            ImageView(withURL: url).frame(width: 200, height: 200).clipped()
          }
        }
      }
    }
  }
}

struct UsersView: View {
  private let users: [User]
  private let title: String

  init(title: String, users: [User]) {
    self.users = users
    self.title = title
  }

  var body: some View {
    VStack {
      Text(title).font(.title2)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(users, id: \.self) { user in
            VStack {
              ImageView(withURL: user.imageURL).frame(width: 80, height: 80).clipped()
              Text(user.name)
            }
          }
        }
      }
    }
  }
}

struct ProfileHeaderView: View {
  private let user: User
  private let canSendMessage: Bool
  private let canStartVideoChat: Bool

  init(user: User, canSendMessage: Bool, canStartVideoChat: Bool) {
    self.user = user
    self.canSendMessage = canSendMessage
    self.canStartVideoChat = canStartVideoChat
  }

  var body: some View {
    VStack {
      HStack(alignment: .center, spacing: 16) {
        Spacer()
        if canStartVideoChat {
          Button(action: {}) {
            Image(systemName: "video")
          }
        }
        if canSendMessage {
          Button(action: {}) {
            Image(systemName: "message")
          }
        }
      }.padding(.trailing)
      ImageView(withURL: user.imageURL).clipShape(Circle()).frame(width: 100, height: 100).clipped()
      Text(user.name).font(.largeTitle)
      HStack {
        Image(systemName: "location")
        Text(user.area).font(.subheadline)
      }.padding(2)
      Text(user.bio).font(.body).padding()
    }
  }
}

// MARK: - History feed views

struct HistoryFeedView: View {
  private let posts: [Post]

  init(posts: [Post]) {
    self.posts = posts
  }

  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack {
        Text("Recent posts").font(.title2)
        ForEach(posts, id: \.self) { post in
          PostView(post: post)
        }
      }
    }
  }
}

struct PostView: View {
  private let post: Post

  init(post: Post) {
    self.post = post
  }

  var body: some View {
    VStack {
      ImageView(withURL: post.pictureURL).frame(height: 200).clipped()
      HStack {
        Text(post.message)
        Spacer()
        HStack {
          Image(systemName: "hand.thumbsup")
          Text(String(post.likesCount))
        }
        HStack {
          Image(systemName: "bubble.right")
          Text(String(post.commentsCount))
        }
      }.padding()
    }
  }
}

struct RestrictedAccessView: View {
  var body: some View {
    VStack {
      Image(systemName: "eye.slash").padding()
      Text("The access to the full profile info is restricted")
    }
  }
}
