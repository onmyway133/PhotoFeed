import UIKit

class FollowingController: TableController<User, UserCell> {
  var userId: String?

  override func loadData() {
    guard let userId = userId else {
      return
    }

    APIClient.shared.loadFollowing(userId: userId) { [weak self] (users) in
      self?.items = users
      self?.tableView.reloadData()
    }
  }

  override func configure(cell: UserCell, model: User) {
    cell.configure(with: model)
  }
}

