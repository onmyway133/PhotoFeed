import UIKit
import UserNotifications

class MainController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Register to get device token for remote notifications
    UIApplication.shared.registerForRemoteNotifications()
    // Register to handle push notification UI
    let options: UNAuthorizationOptions = [.alert, .sound, .badge]
    UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, error) in
      print(error as Any)
    }
  }
}
