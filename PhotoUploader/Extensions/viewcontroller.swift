//
//  viewcontroller.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 6/24/21.
//

import UIKit

extension UITabBarController
{
    public func loadAll() {
        for viewController in self.viewControllers ?? [] {
            if let navigationVC = viewController as? UINavigationController, let rootVC = navigationVC.viewControllers.first {
                let _ = rootVC.view
            } else {
                let _ = viewController.view
            }
        }
    }
}

extension UIViewController
{
    public func implements<T>() -> T? {
        guard let r = self as? T else {
            if let navigationVC = self as? UINavigationController, let rootVC = navigationVC.viewControllers.first as? T {
                return rootVC
            }
            return nil
        }
        return r
    }
}

extension UIViewController {
    func setBackgroundImage(imageName: String) {
        let backgroundImageView = UIImageView(frame: self.view.frame)
        backgroundImageView.image = UIImage(named: imageName)
        self.view.insertSubview(backgroundImageView, at: 0)
        
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
			backgroundImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
			backgroundImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
		])
    }
}

extension UIViewController {
    func top() -> UIViewController {
        var topController: UIViewController = self
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
}

extension UIViewController {
	func getAllViewsOfType<T>(_ type: T, fromView view: UIView) -> [T] {
		return view.subviews.filter{!$0.isHidden}.compactMap { (view) -> [T]? in
			if view is T {
				return [(view as! T)]
			} else {
				return getAllViewsOfType(type, fromView: view)
			}
		}.flatMap({$0})
	}
}
