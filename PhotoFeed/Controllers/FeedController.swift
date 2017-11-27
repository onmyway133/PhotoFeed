import UIKit
import Compass

class FeedController: TableController<Media, MediaCell>, MediaCellDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    // title
    let label = UILabel()
    label.text = "Photo Feed"
    label.textColor = .black
    label.font = UIFont(name: "Noteworthy-Bold", size: 25)
    navigationItem.titleView = label

    // Navigation items
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send"),
                                                        style: .done, target: nil, action: nil)

    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera"),
                                                        style: .done, target: nil, action: nil)
  }

  override func loadData() {
    APIClient.shared.loadMedia { [weak self] mediaList in
      self?.items = mediaList
      self?.tableView.reloadData()
    }
  }

  override func configure(cell: MediaCell, model: Media) {
    cell.configure(with: model)
    cell.delegate = self
  }

  // MARK: - MediaCellDelegate

  func mediaCell(_ cell: MediaCell, didViewLikes mediaId: String) {
    try? Navigator.navigate(urn: "likes:\(mediaId)")
  }

  func mediaCell(_ cell: MediaCell, didViewComments mediaId: String) {
    try? Navigator.navigate(urn: "comments:\(mediaId)")
  }

  func mediaCell(_ cell: MediaCell, didSelectUserName userId: String) {
    try? Navigator.navigate(urn: "user:\(userId)")
  }
}
