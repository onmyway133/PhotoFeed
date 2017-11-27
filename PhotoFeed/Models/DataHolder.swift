import Foundation

struct ListHolder<T: Codable>: Codable {
  enum CodingKeys: String, CodingKey {
    case list = "data"
  }

  let list: [T]
}

struct OneHolder<T: Codable>: Codable {
  enum CodingKeys: String, CodingKey {
    case one = "data"
  }

  let one: T
}
