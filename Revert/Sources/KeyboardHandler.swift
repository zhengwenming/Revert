//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

final class KeyboardHandler: NSObject {
  weak var scrollView: UIScrollView?
  weak var viewController: UIViewController?
  
  deinit {
    NSNotificationCenter.defaultCenter().removeObserver(self)
  }
  
  override init() {
    super.init()
    
    self.registerNotifications()
  }
  
  private func registerNotifications() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowHideNotification:", name: UIKeyboardWillShowNotification, object: nil)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShowHideNotification:", name: UIKeyboardWillHideNotification, object: nil)
  }
  
  func keyboardWillShowHideNotification(notification: NSNotification) {
    guard let scrollView = self.scrollView,
      scrollViewSuperview = scrollView.superview,
      viewController = self.viewController,
      animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval,
      animationCurveInt = notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int,
      animationCurve = UIViewAnimationCurve(rawValue: animationCurveInt),
      keyboardFrameValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else {
        return
    }

    let keyboardFrame = keyboardFrameValue.CGRectValue()
    let keyboardFrameInView = scrollViewSuperview.convertRect(keyboardFrame, fromView: nil)
    let bottomInset = max(scrollView.frame.maxY - keyboardFrameInView.minY, viewController.bottomLayoutGuide.length)
    let animationOptions = UIViewAnimationOptions(rawValue: UInt(animationCurve.rawValue) << 16)

    var contentInsets = scrollView.contentInset
    var scrollIndicatorInsets = scrollView.scrollIndicatorInsets

    contentInsets.bottom = bottomInset
    scrollIndicatorInsets.bottom = bottomInset

    UIView.animateWithDuration(animationDuration, delay: 0, options: animationOptions, animations: {
      scrollView.contentInset = contentInsets
      scrollView.scrollIndicatorInsets = scrollIndicatorInsets
      }, completion: nil)
  }
}
