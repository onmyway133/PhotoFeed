import UIKit

class TableController<Model: Codable, Cell: UITableViewCell>: UITableViewController {
  var items = [Model]()

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

  // MARK: - Subclass

  func loadData() {
    // Subclass to decide
  }

  func configure(cell: Cell, model: Model) {
    // Subclass to decide
  }

  // MARK: - UITableViewDataSource

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
    let item = items[indexPath.row]
    configure(cell: cell, model: item)

    return cell
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
