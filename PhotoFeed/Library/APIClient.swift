import Foundation
import Alamofire

class APIClient {
  static let shared = APIClient()

  private let clientId = "756f0b424b7f48e38c18c1200ad66752"
  private let redirectUri = "http://raywenderlich.com"

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
}
