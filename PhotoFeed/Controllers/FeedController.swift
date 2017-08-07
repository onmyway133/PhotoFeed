import UIKit

class FeedController: UITableViewController {
  var items = [Media]()

  override func viewDidLoad() {
    super.viewDidLoad()

    loadData()
  }

  func loadData() {
    APIClient.shared.loadMedia { [weak self] mediaList in
      self?.items = mediaList
      self?.tableView.reloadData()
    }
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MediaCell", for: indexPath) as! MediaCell
    let item = items[indexPath.row]
    cell.configure(with: item)

    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
