import UIKit

class UserController: UIViewController,
  UICollectionViewDataSource {

  var userId: String?
  var mediaList = [Media]()
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var collectionView: UICollectionView!

  // MARK: - UICollectionViewDataSource
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return mediaList.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCell

    return cell
  }
}
