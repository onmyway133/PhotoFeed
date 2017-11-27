import UIKit

class MenuController: UITableViewController {
  enum Section: Int {
    case about
    case account
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    if indexPath.section == Section.account.rawValue, indexPath.row == 0 {
      logout()
    }
  }

  func logout() {
    APIClient.shared.accessToken = nil
    (UIApplication.shared.delegate as! AppDelegate).showLogin()
  }
}
