import UIKit
import Compass

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginControllerDelegate {

  var window: UIWindow?
  var loginController: LoginController?
  var mainController: MainController?

  // This Router is for post login
  var postLoginRouter = Router()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.tintColor = .black

    if APIClient.shared.accessToken == nil {
      showLogin()
    } else {
      showMain()
    }

    window?.makeKeyAndVisible()

    // Routing
    setupRouting()

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

extension AppDelegate {
  func setupRouting() {
    // Register scheme
    Navigator.scheme = "photofeed"

    // Configure routes for Router
    postLoginRouter.routes = [
      "user:{userId}": UserRoute(),
      "comments:{mediaId}": CommentsRoute(),
      "likes:{mediaId}": LikesRoute(),
      "following:{userId}": FollowingRoute(),
      "follower:{userId}": FollowerRoute(),
      "logout": LogoutRoute()
    ]

    // Register routes you 'd like to support
    Navigator.routes = Array(postLoginRouter.routes.keys)

    Navigator.handle = { [weak self] location in
      guard let selectedController = self?.mainController?.selectedViewController else {
        return
      }

      // Choose the current visible controller
      let currentController = (selectedController as? UINavigationController)?.topViewController
        ?? selectedController

      // Navigate
      self?.postLoginRouter.navigate(to: location, from: currentController)
    }
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    try? Navigator.navigate(url: url)
    return true
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Parse to token string
    let token = deviceToken.map {
      return String(format: "%02.2hhx", $0)
    }.joined()

    // Log it
    print("Your device token is \(token)")
  }

  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    // Always call the completion handler
    defer {
      completionHandler(.newData)
    }

    // Convert into json dictionary
    guard let json = userInfo as? [String: Any] else {
      return
    }

    // Parse to aps
    guard let aps = json["aps"] as? [String: Any] else {
      return
    }

    // Parse to urn
    guard let urn = aps["urn"] as? String else {
      return
    }

    try? Navigator.navigate(urn: urn)
  }
}
