import Foundation

struct DataHolder<T: Codable>: Codable {
  enum CodingKeys: String, CodingKey {
    case list = "data"
  }

  let list: [T]
}
