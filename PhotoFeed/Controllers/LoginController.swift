import UIKit
import Pastel
import WebKit
import Anchors

protocol LoginControllerDelegate: class {
  func loginControllerDidFinish(_ controller: LoginController)
}

class LoginController: UIViewController, WKNavigationDelegate  {
  let pastel = PastelView()
  let webView = WKWebView()
  @IBOutlet weak var loginButton: UIButton!
  weak var delegate: LoginControllerDelegate?

  override func viewDidLoad() {
    super.viewDidLoad()

    loginButton.layer.cornerRadius = 5

    // Pastel
    view.insertSubview(pastel, at: 0)
    activate(pastel.anchor.edges)
    pastel.startAnimation()

    // WebView
    view.addSubview(webView)
    webView.navigationDelegate = self
    webView.alpha = 0
    activate(webView.anchor.edges)
  }

  @IBAction func loginButtonTouched(_ sender: UIButton) {
    let request = URLRequest(url: APIClient.shared.loginUrl)
    webView.load(request)
    UIView.animate(withDuration: 0.25, animations: {
      self.webView.alpha = 1
    })
  }

  // MARK: - WKNavigationDelegate

  func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if let url = navigationAction.request.url,
      url.absoluteString.contains("#access_token") {
      let parts = url.absoluteString.split(separator: "#").last!
      let value = parts.split(separator: "=").last!

      APIClient.shared.accessToken = String(value)
      delegate?.loginControllerDidFinish(self)
    }

    decisionHandler(.allow)
  }
}
