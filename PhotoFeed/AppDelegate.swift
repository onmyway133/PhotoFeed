import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginControllerDelegate {

  var window: UIWindow?
  var loginController: LoginController?
  var mainController: MainController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.tintColor = .black

    if APIClient.shared.accessToken == nil {
      showLogin()
    } else {
      showMain()
    }

    window?.makeKeyAndVisible()

    // Appearance
    UINavigationBar.appearance().barTintColor = 
      UIColor(red: 254/255, green: 254/255, blue: 254/255, alpha: 1)

    return true
  }

  func showLogin() {
    loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as? LoginController
    loginController?.delegate = self
    window?.rootViewController = loginController!

    mainController = nil
  }

  func showMain() {
    mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController") as? MainController
    window?.rootViewController = mainController!

    loginController = nil
  }

  // MARK: - LoginControllerDelegate

  func loginControllerDidFinish(_ controller: LoginController) {
    showMain()
  }
}

