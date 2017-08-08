import UIKit

class UserController: CollectionController<Media, ImageCell>, UICollectionViewDelegateFlowLayout {
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

  // MARK: - UICollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = collectionView.frame.size.width / 3 - 2
    return CGSize(width: size, height: size)
  }
}
