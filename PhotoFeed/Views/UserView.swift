import UIKit
import Anchors
import Kingfisher

class UserView: UIView {
  let avatarImageView = UIImageView()
  let mediaCountLabel = UILabel()
  let followsCountLabel = UILabel()
  let followedByCountLabel = UILabel()
  let messageButton = UIButton()

  func configure(with user: User) {
    avatarImageView.kf.setImage(with: user.avatar)
    mediaCountLabel.text = "\(user.counts?.media ?? 0)"
    followsCountLabel.text = "\(user.counts?.follows ?? 0)"
    followedByCountLabel.text = "\(user.counts?.followedBy ?? 0)"
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    activate(
      avatarImageView.anchor.top.left.constant(8),
      avatarImageView.anchor.size.equal.to(60)
    )
  }
}
