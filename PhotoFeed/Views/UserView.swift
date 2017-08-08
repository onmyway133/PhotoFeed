import UIKit
import Anchors
import Kingfisher

class UserView: UIView {
  let avatarImageView = UIImageView()
  let nameLabel = UILabel()
  let bioLabel = UILabel()
  let websiteLabel = UILabel()
  let mediaCountLabel = UILabel()
  let mediaTextLabel = UILabel()
  let followsCountLabel = UILabel()
  let followsTextLabel = UILabel()
  let followedByCountLabel = UILabel()
  let followedByTextLabel = UILabel()
  let messageButton = UIButton()

  func configure(with user: User) {
    avatarImageView.kf.setImage(with: user.avatar)
    nameLabel.text = user.name
    bioLabel.text = user.bio
    websiteLabel.text = user.website
    mediaCountLabel.text = "\(user.counts?.media ?? 0)"
    followsCountLabel.text = "\(user.counts?.follows ?? 0)"
    followedByCountLabel.text = "\(user.counts?.followedBy ?? 0)"
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    [avatarImageView, nameLabel, bioLabel, websiteLabel,
     mediaCountLabel, followsCountLabel, followedByCountLabel,
     mediaTextLabel, followsTextLabel, followedByTextLabel,
     messageButton].forEach {
      addSubview($0)
    }

    nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
    [mediaCountLabel, followsCountLabel, followedByCountLabel].forEach {
      $0.font = UIFont.boldSystemFont(ofSize: 17)
    }

    [mediaTextLabel, followsTextLabel, followedByTextLabel].forEach {
      $0.textColor = UIColor.darkGray
    }

    mediaTextLabel.text = "posts"
    followsTextLabel.text = "following"
    followedByTextLabel.text = "followers"

    messageButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    messageButton.layer.cornerRadius = 5
    messageButton.layer.borderColor = UIColor.lightGray.cgColor
    messageButton.layer.borderWidth = 1
    messageButton.setTitleColor(UIColor.black, for: .normal)

    activate(
      avatarImageView.anchor.top.left.constant(8),
      avatarImageView.anchor.size.equal.to(80),

      nameLabel.anchor.left.constant(8),
      nameLabel.anchor.top.equal.to(avatarImageView.anchor.bottom).constant(20),

      bioLabel.anchor.left.constant(8),
      bioLabel.anchor.top.equal.to(nameLabel.anchor.bottom).constant(8),

      websiteLabel.anchor.left.constant(8),
      websiteLabel.anchor.top.equal.to(bioLabel.anchor.bottom).constant(8),

      followsCountLabel.anchor.right.constant(-50),
      followsCountLabel.anchor.top.constant(10),

      followsTextLabel.anchor.top.equal
        .to(followsCountLabel.anchor.bottom).constant(8),
      followsTextLabel.anchor.centerX.equal
        .to(followsCountLabel.anchor.centerX),

      followedByCountLabel.anchor.right.equal
        .to(followsCountLabel.anchor.left).constant(-80),
      followedByCountLabel.anchor.top.constant(10),

      followedByTextLabel.anchor.top.equal
        .to(followedByCountLabel.anchor.bottom).constant(8),
      followedByTextLabel.anchor.centerX.equal
        .to(followedByCountLabel.anchor.centerX),

      mediaCountLabel.anchor.right.equal
        .to(followedByCountLabel.anchor.left).constant(-80),
      mediaCountLabel.anchor.top.constant(10),

      mediaTextLabel.anchor.top.equal
        .to(mediaCountLabel.anchor.bottom).constant(8),
      mediaTextLabel.anchor.centerX.equal
        .to(mediaCountLabel.anchor.centerX),

      messageButton.anchor.top.equal
        .to(mediaTextLabel.anchor.bottom).constant(10),
      messageButton.anchor.left.equal
        .to(avatarImageView.anchor.right).constant(50),
      messageButton.anchor.right.constant(-30),
      messageButton.anchor.height.equal.to(36)
    )
  }
}
