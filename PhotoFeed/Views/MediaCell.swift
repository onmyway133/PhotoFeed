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
import Kingfisher

protocol MediaCellDelegate: class {
  func mediaCell(_ cell: MediaCell, didViewLikes mediaId: String)
  func mediaCell(_ cell: MediaCell, didViewComments mediaId: String)
  func mediaCell(_ cell: MediaCell, didSelectUserName userId: String)
}

class MediaCell: UITableViewCell {
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var userButton: UIButton!
  @IBOutlet weak var locationLabel: UILabel!
  @IBOutlet weak var contextButton: UIButton!
  @IBOutlet weak var mediaImageView: UIImageView!
  @IBOutlet weak var likeButton: UIButton!
  @IBOutlet weak var commentButton: UIButton!
  @IBOutlet weak var sendButton: UIButton!
  @IBOutlet weak var bookmarkButton: UIButton!
  @IBOutlet weak var usersWhoLikeButton: UIButton!
  @IBOutlet weak var usersWhoCommentButton: UIButton!
  @IBOutlet weak var captionLabel: UILabel!

  private var media: Media?
  weak var delegate: MediaCellDelegate?

  override func layoutSubviews() {
    super.layoutSubviews()

    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
  }

  func configure(with media: Media) {
    self.media = media

    avatarImageView.kf.setImage(with: media.user.avatar)
    userButton.setTitle(media.user.username, for: .normal)
    locationLabel.text = media.location?.name
    mediaImageView.kf.setImage(with: media.images.standard.url)
    usersWhoLikeButton.setTitle("\(media.likes.count) likes", for: .normal)
    usersWhoCommentButton.setTitle("View all \(media.comments.count) comments", for: .normal)
    captionLabel.text = media.caption?.text
  }

  @IBAction func contextButtonTouched(_ sender: UIButton) {
    // TODO
  }

  @IBAction func bookmarkButtonTouched(_ sender: UIButton) {
    // TODO
  }

  @IBAction func viewLikeButtonTouched(_ sender: UIButton) {
    guard let id = media?.id else {
      return
    }

    delegate?.mediaCell(self, didViewLikes: id)
  }
  
  @IBAction func viewCommentButtonTouched(_ sender: UIButton) {
    guard let id = media?.id else {
      return
    }

    delegate?.mediaCell(self, didViewComments: id)
  }

  @IBAction func usernameButtonTouched(_ sender: UIButton) {
    guard let id = media?.user.id else {
      return
    }

    delegate?.mediaCell(self, didSelectUserName: id)
  }
}
