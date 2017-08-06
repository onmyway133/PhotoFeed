import UIKit

class FeedController: UITableViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    APIClient.shared.loadMedia { mediaList in

    }
  }
}
