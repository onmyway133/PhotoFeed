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
import Anchors
import Compass

class UserController: CollectionController<Media, ImageCell>, UICollectionViewDelegateFlowLayout, UserViewDelegate {

  var userId: String?
  let userView = UserView()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Header
    let offset: CGFloat = 230
    collectionView?.addSubview(userView)
    collectionView?.contentInset.top = offset
    userView.frame = CGRect(x: 0,
                            y: -offset,
                            width: collectionView!.frame.size.width,
                            height: offset)

    userView.messageButton.setTitle("Message", for: .normal)
    userView.delegate = self

    // Navigation bar
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ellipsis"),
                                                        style: .done, target: nil, action: nil)
  }

  override func loadData() {
    guard let userId = userId else {
      return
    }

    APIClient.shared.loadMedia(userId: userId) { [weak self] (mediaList) in
      self?.items = mediaList
      self?.collectionView?.reloadData()
    }

    APIClient.shared.loadInfo(userId: userId) { [weak self] (user) in
      self?.userView.configure(with: user)
      self?.title = user.username
      self?.parent?.title = user.username
    }
  }

  override func configure(cell: ImageCell, model: Media) {
    cell.configure(with: model.images.thumbnail)
  }

  // MARK: - UICollectionViewDelegateFlowLayout

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = collectionView.frame.size.width / 3 - 2
    return CGSize(width: size, height: size)
  }

  // MARK: - UserViewDelegate

  func userView(_ view: UserView, didViewFollower userId: String) {
    try? Navigator.navigate(urn: "follower:\(userId)")
  }

  func userView(_ view: UserView, didViewFollowing userId: String) {
    try? Navigator.navigate(urn: "following:\(userId)")
  }
}
