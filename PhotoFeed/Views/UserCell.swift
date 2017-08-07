import UIKit
import Kingfisher

class UserCell: UITableViewCell {
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var usernameLabel: UIButton!
  @IBOutlet weak var nameLabel: UILabel!

  override func layoutSubviews() {
    super.layoutSubviews()

    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
  }

  func configure(with user: User) {
    avatarImageView.kf.setImage(with: user.avatar)
    usernameLabel.setTitle(user.username, for: .normal)
    nameLabel.text = user.name
  }
}
