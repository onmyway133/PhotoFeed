import Foundation

struct User: Codable {
  enum CodingKeys: String, CodingKey {
    case id
    case name = "full_name"
    case avatar = "profile_picture"
    case username
    case firstName = "first_name"
    case lastName = "last_name"
    case bio
    case website
    case counts
  }

  struct Counts: Codable {
    enum CodingKeys: String, CodingKey {
      case media
      case follows
      case followedBy = "followed_by"
    }

    let media: Int
    let follows: Int
    let followedBy: Int
  }

  let id: String
  let name: String?
  let avatar: URL
  let username: String
  let firstName: String?
  let lastName: String?
  let bio: String?
  let website: String?
  let counts: Counts?
}
