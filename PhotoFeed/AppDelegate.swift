/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology. Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
