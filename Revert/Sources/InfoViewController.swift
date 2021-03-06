//
//  Copyright © 2015 Itty Bitty Apps. All rights reserved.

import UIKit

final class InfoViewController: UIViewController, SettableHomeItem {
  var item: HomeItem?

  override func viewDidLoad() {
    super.viewDidLoad()

    guard let item = self.item else {
      fatalError("Item should be set before `-viewDidLoad`")
    }

    guard let infoFilename = item.infoFilename else {
      fatalError("Cannot display without a valid info filename")
    }

    // Configure the view
    self.imageView.image = UIImage(named: item.iconName)
    self.titleLabel.text = item.title

    let htmlString = infoHTMLWithContent(infoFilename)
    self.webView.loadHTMLString(htmlString, baseURL: nil)
  }

  // MARK: Private

  @IBOutlet private weak var imageView: UIImageView!
  @IBOutlet private weak var webView: UIWebView!
  @IBOutlet private weak var titleLabel: UILabel!

  @IBAction private func dismiss(sender: UIBarButtonItem) {
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}

// MARK:- UIWebViewDelegate
extension InfoViewController: UIWebViewDelegate {
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    if let URL = request.URL where URL != NSURL(string: "about:blank") {
      UIApplication.sharedApplication().openURL(URL)
      return false
    }
    return true
  }
}
