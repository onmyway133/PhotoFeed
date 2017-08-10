import UIKit
import Anchors
import Kingfisher

protocol UserViewDelegate: class {
  func userView(_ view: UserView, didViewFollowing userId: String)
  func userView(_ view: UserView, didViewFollower userId: String)
}

class UserView: UIView {
  let avatarImageView = UIImageView()
  let nameLabel = UILabel()
  let bioLabel = UILabel()
  let websiteLabel = UILabel()
  let mediaCountLabel = UILabel()
  let mediaTextLabel = UILabel()
  let followsCountButton = UIButton()
  let followsTextLabel = UILabel()
  let followedByCountButton = UIButton()
  let followedByTextLabel = UILabel()
  let messageButton = UIButton()

  private var userId: String?
  weak var delegate: UserViewDelegate?

  func configure(with user: User) {
    self.userId = user.id

    avatarImageView.kf.setImage(with: user.avatar)
    nameLabel.text = user.name
    bioLabel.text = user.bio
    websiteLabel.text = user.website
    mediaCountLabel.text = "\(user.counts?.media ?? 0)"
    followsCountButton.setTitle("\(user.counts?.follows ?? 0)", for: .normal)
    followedByCountButton.setTitle("\(user.counts?.followedBy ?? 0)", for: .normal)
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    avatarImageView.clipsToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.size.height/2
  }

  override func didMoveToSuperview() {
    super.didMoveToSuperview()

    [avatarImageView, nameLabel, bioLabel, websiteLabel,
     mediaCountLabel, followsCountButton, followedByCountButton,
     mediaTextLabel, followsTextLabel, followedByTextLabel,
     messageButton].forEach {
      addSubview($0)
    }

    nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
    mediaCountLabel.font = UIFont.boldSystemFont(ofSize: 17)
    [followsCountButton, followedByCountButton].forEach {
      $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
      $0.setTitleColor(.black, for: .normal)
    }

    followsCountButton.addTarget(self,
                                 action: #selector(viewFollowing),
                                 for: .touchUpInside)
    followedByCountButton.addTarget(self,
                                    action: #selector(viewFollower),
                                    for: .touchUpInside)

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
      avatarImageView.anchor.size.equal.to(100),

      nameLabel.anchor.left.constant(8),
      nameLabel.anchor.top.equal.to(avatarImageView.anchor.bottom).constant(20),

      bioLabel.anchor.left.constant(8),
      bioLabel.anchor.top.equal.to(nameLabel.anchor.bottom).constant(8),

      websiteLabel.anchor.left.constant(8),
      websiteLabel.anchor.top.equal.to(bioLabel.anchor.bottom).constant(8),

      followsCountButton.anchor.right.constant(-50),
      followsCountButton.anchor.top.constant(10),

      followsTextLabel.anchor.top.equal
        .to(followsCountButton.anchor.bottom).constant(8),
      followsTextLabel.anchor.centerX.equal
        .to(followsCountButton.anchor.centerX),

      followedByCountButton.anchor.right.equal
        .to(followsCountButton.anchor.left).constant(-80),
      followedByCountButton.anchor.top.constant(10),

      followedByTextLabel.anchor.top.equal
        .to(followedByCountButton.anchor.bottom).constant(8),
      followedByTextLabel.anchor.centerX.equal
        .to(followedByCountButton.anchor.centerX),

      mediaCountLabel.anchor.right.equal
        .to(followedByCountButton.anchor.left).constant(-80),
      mediaCountLabel.anchor.top.constant(10),

      mediaTextLabel.anchor.top.equal
        .to(mediaCountLabel.anchor.bottom).constant(8),
      mediaTextLabel.anchor.centerX.equal
        .to(mediaCountLabel.anchor.centerX),

      messageButton.anchor.top.equal
        .to(mediaTextLabel.anchor.bottom).constant(10),
      messageButton.anchor.left.equal
        .to(avatarImageView.anchor.right).constant(30),
      messageButton.anchor.right.constant(-30),
      messageButton.anchor.height.equal.to(36)
    )
  }

  @objc func viewFollowing(_sender: UIButton) {
    guard let userId = userId else {
      return
    }

    delegate?.userView(self, didViewFollowing: userId)
  }

  @objc func viewFollower(_sender: UIButton) {
    guard let userId = userId else {
      return
    }

    delegate?.userView(self, didViewFollower: userId)
  }
}
