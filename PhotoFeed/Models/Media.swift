import Foundation

struct Media: Codable {
  struct Comments: Codable {
    let count: Int
  }

  struct Likes: Codable {
    let count: Int
  }

  struct Images: Codable {
    enum CodingKeys : String, CodingKey {
      case standard = "standard_resolution"
      case thumbnail
    }

    let standard: Image
    let thumbnail: Image
  }

  let id: String
  let comments: Comments
  let likes: Likes
  let images: Images
  let link: URL
  let user: User
}
