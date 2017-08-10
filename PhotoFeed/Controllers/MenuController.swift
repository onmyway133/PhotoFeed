import UIKit

protocol MenuControllerDelegate: class {
  func menuControllerDidSelectLogout(_ controller: MenuController)
}

class MenuController: UITableViewController {
  enum Section: Int {
    case about
    case account
  }

  weak var delegate: MenuControllerDelegate?

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    if indexPath.section == Section.account.rawValue, indexPath.row == 0 {
      delegate?.menuControllerDidSelectLogout(self)
    }
  }
}
