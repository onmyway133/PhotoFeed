import UIKit

class BaseController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    loadData()

    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
  }

  @objc private func handleRefresh() {
    refreshControl?.endRefreshing()
    loadData()
  }

  func loadData() {
    // Subclass to decide
  }
}
