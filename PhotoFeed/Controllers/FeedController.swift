import UIKit

class FeedController: BaseController<Media, MediaCell>, MediaCellDelegate {

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
}
