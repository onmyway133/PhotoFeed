import Foundation

struct User: Codable {
  enum CodingKeys : String, CodingKey {
    case id
    case name = "full_name"
    case avatar = "profile_picture"
    case username
  }

  let id: String
  private let name: String
  let avatar: URL
  private let username: String

  var displayName: String {
    return name.isEmpty ? username : name
  }
}
