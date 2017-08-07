import UIKit

class BaseController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    reloadData()

    refreshControl = UIRefreshControl()
    refreshControl?.addTarget(self, action: #selector(reloadData), for: .valueChanged)
  }

  @objc func reloadData() {
    // Subclass to decide
  }
}
