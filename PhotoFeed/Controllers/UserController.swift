import UIKit
import Anchors

class UserController: CollectionController<Media, ImageCell>, UICollectionViewDelegateFlowLayout {

  var userId: String?
  let userView = UserView()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Header
    let offset: CGFloat = 230
    collectionView?.addSubview(userView)
    collectionView?.contentInset.top = offset
    userView.frame = CGRect(x: 0,
                            y: -offset,
                            width: collectionView!.frame.size.width,
                            height: offset)

    userView.messageButton.setTitle("Message", for: .normal)

    // Navigation bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ellipsis"),
                                                        style: .done, target: nil, action: nil)
  }

  override func loadData() {
    guard let userId = userId else {
      return
    }

    APIClient.shared.loadMedia(userId: userId) { [weak self] (mediaList) in
      self?.items = mediaList
      self?.collectionView?.reloadData()
    }

    APIClient.shared.loadInfo(userId: userId) { [weak self] (user) in
      self?.userView.configure(with: user)
      self?.title = user.username
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
