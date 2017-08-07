import UIKit

class FeedController: BaseController<Media, MediaCell> {

  override func loadData() {
    APIClient.shared.loadMedia { [weak self] mediaList in
      self?.items = mediaList
      self?.tableView.reloadData()
    }
  }

  override func configure(cell: MediaCell, model: Media) {
    cell.configure(with: model)
  }
}
