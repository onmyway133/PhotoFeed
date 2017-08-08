import UIKit

class UserController: CollectionController<Media, ImageCell> {
  var userId: String?

  override func loadData() {
    guard let userId = userId else {
      return
    }

    APIClient.shared.loadMedia(userId: userId) { [weak self] (mediaList) in
      self?.items = mediaList
      self?.collectionView?.reloadData()
    }
  }

  override func configure(cell: ImageCell, model: Media) {
    cell.configure(with: model.images.thumbnail)
  }
}
