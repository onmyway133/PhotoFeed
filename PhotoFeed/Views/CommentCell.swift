import UIKit
import Kingfisher

class CommentCell: UITableViewCell {
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var usernameButton: UIButton!
  @IBOutlet weak var commentLabel: UILabel!

  override func layoutSubviews() {
    super.layoutSubviews()

    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
  }

  func configure(with comment: Comment) {
    avatarImageView.kf.setImage(with: comment.from.avatar)
    usernameButton.setTitle(comment.from.username, for: .normal)
    commentLabel.text = comment.text
  }

  @IBAction func usernameButtonTouched(_ sender: UIButton) {

  }
}
