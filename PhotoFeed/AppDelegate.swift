//
//  AppDelegate.swift
//  PhotoFeed
//
//  Created by Khoa Pham on 05.08.2017.
//  Copyright © 2017 Raywenderlich. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoginControllerDelegate {

  var window: UIWindow?
  var loginController: LoginController?
  var mainController: MainController?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)

    if APIClient.shared.accessToken == nil {
      showLogin()
    } else {
      showMain()
    }

    window?.makeKeyAndVisible()

    return true
  }

  func showLogin() {
    loginController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as? LoginController
    loginController?.delegate = self
    window?.rootViewController = loginController!
  }

  func showMain() {
    mainController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainController") as? MainController
    window?.rootViewController = mainController!
  }

  // MARK: - LoginControllerDelegate

  func loginControllerDidFinish(_ controller: LoginController) {
    loginController = nil
    showMain()
  }
}

