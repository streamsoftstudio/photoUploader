//
//  navigationcontroller.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 6/26/21.
//

import UIKit
import ObjectiveC

public extension UINavigationController
{
    func pushFromBottom( viewController vc: UIViewController)
    {
        if let top = self.topViewController, top.isEqual(vc) {
            return
        }
        
        
        self.view.layer.add(CATransition().segueFromBottom(), forKey: kCATransition)
        self.pushViewController(vc, animated: false)
    }
    
    func popToBottom()
    {
        self.view.layer.add(CATransition().segueFromBottom(), forKey: kCATransition)
        self.popViewController(animated: false)
    }
}

extension CATransition {
    
    //New viewController will appear from bottom of screen.
    func segueFromBottom() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromTop
        return self
    }
    //New viewController will appear from top of screen.
    func segueFromTop() -> CATransition {
        self.duration = 0.375 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromBottom
        return self
    }
    //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 0.3 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
    //New viewController will appear from right side of screen.
    func segueFromRight() -> CATransition {
        self.duration = 0.3 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will pop from right side of screen.
    func popFromRight() -> CATransition {
        self.duration = 0.3 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromRight
        return self
    }
    //New viewController will appear from left side of screen.
    func popFromLeft() -> CATransition {
        self.duration = 0.3 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.reveal
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}

public extension UINavigationController {
	func presentIfAlreadyPresenting(vc: UIViewController) {
		if let alreadyPresentedVC = self.presentedViewController {
			alreadyPresentedVC.dismiss(animated: true, completion: {
				self.present(vc, animated: true, completion: nil)
			})
		} else {
			self.present(vc, animated: true, completion: nil)
		}
	}
}
