/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology. Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Compass

class FeedController: TableController<Media, MediaCell>, MediaCellDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()

    // title
    let label = UILabel()
    label.text = "Photo Feed"
    label.textColor = .black
    label.font = UIFont(name: "Noteworthy-Bold", size: 25)
    navigationItem.titleView = label

    // Navigation items
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "send"),
                                                        style: .done, target: nil, action: nil)

    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "camera"),
                                                        style: .done, target: nil, action: nil)
  }

  override func loadData() {
    APIClient.shared.loadMedia { [weak self] mediaList in
      self?.items = mediaList
      self?.tableView.reloadData()
    }
  }

  override func configure(cell: MediaCell, model: Media) {
    cell.configure(with: model)
    cell.delegate = self
  }

  // MARK: - MediaCellDelegate

  func mediaCell(_ cell: MediaCell, didViewLikes mediaId: String) {
    try? Navigator.navigate(urn: "likes:\(mediaId)")
  }

  func mediaCell(_ cell: MediaCell, didViewComments mediaId: String) {
    try? Navigator.navigate(urn: "comments:\(mediaId)")
  }

  func mediaCell(_ cell: MediaCell, didSelectUserName userId: String) {
    try? Navigator.navigate(urn: "user:\(userId)")
  }
}
