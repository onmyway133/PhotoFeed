import UIKit

class CommentCell: UITableViewCell {
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var usernameButton: UIButton!
  @IBOutlet weak var commentLabel: UILabel!

  func configure(with comment: Comment) {
    
  }

  @IBAction func usernameButtonTouched(_ sender: UIButton) {

  }
}
