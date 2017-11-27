import UIKit
import Compass

class MenuController: UITableViewController {
  enum Section: Int {
    case about
    case account
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    if indexPath.section == Section.account.rawValue, indexPath.row == 0 {
      try? Navigator.navigate(urn: "logout")
    }
  }
}
