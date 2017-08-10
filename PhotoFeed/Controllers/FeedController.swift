import UIKit

class FeedController: TableController<Media, MediaCell>, MediaCellDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    // title
    let label = UILabel()
    label.text = "Photo Feed"
    label.textColor = .black
    label.font = UIFont(name: "Noteworthy-Bold", size: 25)
    navigationItem.titleView = label
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
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LikesController") as! LikesController
    controller.mediaId = mediaId
    navigationController?.pushViewController(controller, animated: true)
  }

  func mediaCell(_ cell: MediaCell, didViewComments mediaId: String) {
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsController") as! CommentsController
    controller.mediaId = mediaId
    navigationController?.pushViewController(controller, animated: true)
  }

  func mediaCell(_ cell: MediaCell, didSelectUserName userId: String) {
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserController") as! UserController
    controller.userId = userId
    navigationController?.pushViewController(controller, animated: true)
  }
}
