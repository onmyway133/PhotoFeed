import UIKit
import Anchors

class ProfileController: UIViewController {
  var userController: UserController!

  override func viewDidLoad() {
    super.viewDidLoad()

    // User
    userController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(withIdentifier: "UserController") as! UserController

    userController.userId = "self"
    addChildViewController(userController)
    view.addSubview(userController.collectionView!)
    activate(userController.collectionView!.anchor.edges)
    userController.didMove(toParentViewController: self)

    // Navigation bar
    navigationItem.rightBarButtonItem =
      UIBarButtonItem(image: UIImage(named: "clock"),
                      style: .done, target: nil, action: nil)

    navigationItem.leftBarButtonItem =
      UIBarButtonItem(image: UIImage(named: "add"),
                      style: .done, target: nil, action: nil)
  }
}
