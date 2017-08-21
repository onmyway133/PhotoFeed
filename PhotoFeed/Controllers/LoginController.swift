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
