import Foundation

struct User: Codable {
  enum CodingKeys : String, CodingKey {
    case id
    case name = "full_name"
    case avatar = "profile_picture"
    case username
  }

  let id: String
  let name: String
  let avatar: URL
  let username: String
}
