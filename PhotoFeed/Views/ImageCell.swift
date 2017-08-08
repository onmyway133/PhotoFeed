import UIKit
import Kingfisher

class ImageCell: UICollectionViewCell {
  @IBOutlet weak var imageView: UIImageView!

  func configure(with image: Image) {
    imageView.kf.setImage(with: image.url)
  }
}
