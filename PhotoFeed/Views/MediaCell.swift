import UIKit
import Kingfisher

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
  override func layoutSubviews() {
    super.layoutSubviews()

    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
  }

  func configure(with media: Media) {
    avatarImageView.kf.setImage(with: media.user.avatar)
    userButton.setTitle(media.user.username, for: .normal)
    locationLabel.text = media.location?.name
    mediaImageView.kf.setImage(with: media.images.standard.url)
    usersWhoLikeButton.setTitle("\(media.likes.count) likes", for: .normal)
    usersWhoCommentButton.setTitle("View all \(media.comments.count) comments", for: .normal)
    captionLabel.text = media.caption?.text
  }

  @IBAction func contextButtonTouched(_ sender: UIButton) {

  }

  @IBAction func bookmarkButtonTouched(_ sender: UIButton) {

  }

  @IBAction func viewLikeButtonTouched(_ sender: UIButton) {

  }
  
  @IBAction func viewCommentButtonTouched(_ sender: UIButton) {

  }

  @IBAction func usernameButtonTouched(_ sender: UIButton) {

  }
}
