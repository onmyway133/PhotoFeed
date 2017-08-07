import UIKit

class BaseController: UITableViewController {
  func reloadData() {
    // Subclass to decide
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    reloadData()

    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
  }
}
