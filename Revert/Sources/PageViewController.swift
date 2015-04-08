//
//  Copyright (c) 2015 Itty Bitty Apps. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {
  
  private var pageViewController: UIPageViewController
  private lazy var pages: [UIViewController] = {
    let firstViewController = UIViewController(backgroundColor: UIColor.peterRiverColor())
    let secondViewController = UIViewController(backgroundColor: UIColor.wetAsphaltColor())
    let thirdViewController = UIViewController(backgroundColor: UIColor.alizarinColor())
    
    return [firstViewController, secondViewController, thirdViewController]
  }()
  
  required init(coder aDecoder: NSCoder) {
    self.pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)

    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.configurePageViewController()
  }
  
  private func configurePageViewController() {
    self.addChildViewController(self.pageViewController)

    self.pageViewController.dataSource = self
    self.pageViewController.setViewControllers([self.pages.first!], direction: .Forward, animated: false, completion: nil)
    self.pageViewController.didMoveToParentViewController(self)
   
    let constraints = [
      NSLayoutConstraint(item: self.view, attribute: .Left, relatedBy: .Equal, toItem: self.pageViewController.view, attribute: .Left, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: self.view, attribute: .Right, relatedBy: .Equal, toItem: self.pageViewController.view, attribute: .Right, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: self.view, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0.0),
      NSLayoutConstraint(item: self.view, attribute: .Bottom, relatedBy: .Equal, toItem: self.bottomLayoutGuide, attribute: .Top, multiplier: 1.0, constant: 0.0)
    ]

    self.view.addSubview(self.pageViewController.view)
    self.view.addConstraints(constraints)
  }
}

// MARK: UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    if let index = find(self.pages, viewController) {
      return index > 0 ? self.pages[index - 1] : nil
    }
    fatalError("View Controller should always be present in pages array")
  }
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    if let index = find(self.pages, viewController) {
      return index < self.pages.count - 1 ? self.pages[index + 1] : nil
    }
    fatalError("View Controller should always be present in pages array")
  }
}
