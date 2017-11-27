import UIKit
import Compass

struct UserRoute: Routable {
  func navigate(to location: Location, from currentController: CurrentController) throws {
    guard let userId = location.arguments["userId"] else {
      return
    }

    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserController") as! UserController
    controller.userId = userId
    currentController.navigationController?.pushViewController(controller, animated: true)
  }
}

struct LikesRoute: Routable {
  func navigate(to location: Location, from currentController: CurrentController) throws {
    guard let mediaId = location.arguments["mediaId"] else {
      return
    }

    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LikesController") as! LikesController
    controller.mediaId = mediaId
    currentController.navigationController?.pushViewController(controller, animated: true)
  }
}

struct CommentsRoute: Routable {
  func navigate(to location: Location, from currentController: CurrentController) throws {
    guard let mediaId = location.arguments["mediaId"] else {
      return
    }

    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CommentsController") as! CommentsController
    controller.mediaId = mediaId
    currentController.navigationController?.pushViewController(controller, animated: true)
  }
}

struct FollowingRoute: Routable {
  func navigate(to location: Location, from currentController: CurrentController) throws {
    guard let userId = location.arguments["userId"] else {
      return
    }

    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FollowingController") as! FollowingController
    controller.userId = userId
    currentController.navigationController?.pushViewController(controller, animated: true)
  }
}

struct FollowerRoute: Routable {
  func navigate(to location: Location, from currentController: CurrentController) throws {
    guard let userId = location.arguments["userId"] else {
      return
    }
    
    let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FollowerController") as! FollowerController
    controller.userId = userId
    currentController.navigationController?.pushViewController(controller, animated: true)
  }
}

struct LogoutRoute: Routable {
  func navigate(to location: Location, from currentController: CurrentController) throws {
    APIClient.shared.accessToken = nil
    (UIApplication.shared.delegate as! AppDelegate).showLogin()
  }
}
