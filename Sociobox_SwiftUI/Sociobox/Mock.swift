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

import Foundation

enum Mock {
  static func user() -> User {
    return User(
      name: "Belle",
      imageURL: "https://images.unsplash.com/photo-1522593596038-8a7b75a0f2bc?ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80",
      bio: "I love hiking, exploring new countries and traditional dishes",
      area: "Italy",
      friends: friends(),
      photos: photos(),
      historyFeed: posts()
    )
  }

  static func photos() -> [String] {
    return [
      "https://images.unsplash.com/photo-1553808354-74b53671c8b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1570996915537-dd53ef642ef7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1553808353-54724c294f0c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1552396422-9d90144ceb97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1573314481772-97f0b6102c17?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1586866928487-2af5b3850105?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80"
    ]
  }

  static func posts() -> [Post] {
    return [
      Post(pictureURL: "https://images.unsplash.com/photo-1440186347098-386b7459ad6b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1501554728187-ce583db33af7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "Such a nice view!", likesCount: 32, commentsCount: 5),
      Post(pictureURL: "https://images.unsplash.com/photo-1500049242364-5f500807cdd7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1442570468985-f63ed5de9086?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1574325298943-eacd397f382d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "I love train rides", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1549872178-96db16a53ca8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "Ready for a new adventure", likesCount: 20, commentsCount: 10)
    ]
  }

  static func friends() -> [User] {
    return [
      User(name: "Leila", imageURL: "https://images.unsplash.com/photo-1474073705359-5da2a8270c64?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
      User(name: "Ingrid", imageURL: "https://images.unsplash.com/photo-1520512202623-51c5c53957df?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
      User(name: "Leon", imageURL: "https://images.unsplash.com/photo-1534614971-6be99a7a3ffd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
      User(name: "Jonathan", imageURL: "https://images.unsplash.com/photo-1484517186945-df8151a1a871?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
      User(name: "Jay", imageURL: "https://images.unsplash.com/photo-1485361767769-5ceffc9f2144?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
      User(name: "Harriette", imageURL: "https://images.unsplash.com/photo-1468817814611-b7edf94b5d60?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: [])
    ]
  }
}
