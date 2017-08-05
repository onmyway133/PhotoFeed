import UIKit
import Pastel

class LoginController: UIViewController {
  @IBOutlet weak var pastelView: PastelView!
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    loginButton.layer.cornerRadius = 5
  }
}
