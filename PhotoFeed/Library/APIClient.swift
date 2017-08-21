/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology. Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]
typealias JSONArray = [JSONDictionary]

class APIClient {
  static let shared = APIClient()

  private let clientId = "756f0b424b7f48e38c18c1200ad66752"
  private let redirectUri = "http://raywenderlich.com"

  var parameters: JSONDictionary {
    guard let accessToken = accessToken else {
      return [:]
    }

    return [
      "access_token": accessToken,
      "scope": "follower_list"
    ]
  }

  var accessToken: String? {
    get {
      return UserDefaults.standard.string(forKey: "accessToken")
    }
    set {
      if let newValue = newValue {
        UserDefaults.standard.set(newValue, forKey: "accessToken")
      } else {
        UserDefaults.standard.removeObject(forKey: "accessToken")
      }

      UserDefaults.standard.synchronize()
    }
  }

  var loginUrl: URL {
    return URL(string: "https://api.instagram.com/oauth/authorize/?client_id=\(clientId)&redirect_uri=\(redirectUri)&response_type=token")!
  }

  func loadMedia(userId: String = "self", completion: @escaping ([Media]) -> Void) {
    request("https://api.instagram.com/v1/users/\(userId)/media/recent",
            parameters: parameters)
    .responseData(completionHandler: { (response) in
      if let data = response.result.value {
        do {
          let holder = try JSONDecoder().decode(ListHolder<Media>.self, from: data)
          DispatchQueue.main.async {
            completion(holder.list)
          }
        } catch {
          print(error)
        }
      }
    })
  }

  func loadUsersWhoLike(mediaId: String, completion: @escaping ([User]) -> Void) {
    request("https://api.instagram.com/v1/media/\(mediaId)/likes",
            parameters: parameters)
    .responseData(completionHandler: { (response) in
      if let data = response.result.value {
        do {
          let holder = try JSONDecoder().decode(ListHolder<User>.self, from: data)
          DispatchQueue.main.async {
            completion(holder.list)
          }
        } catch {
          print(error)
        }
      }
    })
  }

  func loadComments(mediaId: String, completion: @escaping ([Comment]) -> Void) {
    request("https://api.instagram.com/v1/media/\(mediaId)/comments",
      parameters: parameters)
    .responseData(completionHandler: { (response) in
      if let data = response.result.value {
        do {
          let holder = try JSONDecoder().decode(ListHolder<Comment>.self, from: data)
          DispatchQueue.main.async {
            completion(holder.list)
          }
        } catch {
          print(error)
        }
      }
    })
  }

  func loadInfo(userId: String, completion: @escaping (User) -> Void) {
    request("https://api.instagram.com/v1/users/\(userId)",
      parameters: parameters)
    .responseData(completionHandler: { (response) in
      if let data = response.result.value {
        do {
          let holder = try JSONDecoder().decode(OneHolder<User>.self, from: data)
          DispatchQueue.main.async {
            completion(holder.one)
          }
        } catch {
          print(error)
        }
      }
    })
  }

  func loadFollowing(userId: String, completion: @escaping ([User]) -> Void) {
    request("https://api.instagram.com/v1/users/\(userId)/follows",
      parameters: parameters)
    .responseData(completionHandler: { (response) in
      if let data = response.result.value {
        do {
          let holder = try JSONDecoder().decode(ListHolder<User>.self, from: data)
          DispatchQueue.main.async {
            completion(holder.list)
          }
        } catch {
          print(error)
        }
      }
    })
  }

  func loadFollowers(userId: String, completion: @escaping ([User]) -> Void) {
    request("https://api.instagram.com/v1/users/\(userId)/followed-by",
      parameters: parameters)
    .responseData(completionHandler: { (response) in
      if let data = response.result.value {
        do {
          let holder = try JSONDecoder().decode(ListHolder<User>.self, from: data)
          DispatchQueue.main.async {
            completion(holder.list)
          }
        } catch {
          print(error)
        }
      }
    })
  }
}
