import UIKit

class CommentsController: TableController<Comment, CommentCell> {
  var mediaId: String?

  override func loadData() {
    guard let mediaId = mediaId else {
      return
    }

    APIClient.shared.loadComments(mediaId: mediaId) { [weak self] (comments) in
      self?.items = comments
      self?.tableView.reloadData()
    }
  }

  override func configure(cell: CommentCell, model: Comment) {
    cell.configure(with: model)
  }
}
