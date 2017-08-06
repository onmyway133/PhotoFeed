import Foundation

struct User: Codable {
  enum CodingKeys : String, CodingKey {
    case id
    case name = "full_name"
    case picture = "profile_picture"
    case username
  }

  let id: String
  let name: String
  let picture: URL
  let username: String
}
