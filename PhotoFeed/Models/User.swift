import Foundation

struct User: Codable {
  enum CodingKeys : String, CodingKey {
    case id
    case name = "full_name"
    case avatar = "profile_picture"
    case username
    case firstName = "first_name"
    case lastName = "last_name"
  }

  let id: String
  let name: String?
  let avatar: URL
  let username: String
  let firstName: String?
  let lastName: String?
}
