//
//  view.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 6/25/21.
//

import Foundation
import UIKit

//extension UIView {
//
//    @IBInspectable
//    var viewShadowRadius: CGFloat {
//        get { return layer.shadowRadius  }
//        set { layer.shadowRadius = newValue }
//    }
//    @IBInspectable
//    var viewShadowOpacity: Float {
//        get { return layer.shadowOpacity }
//        set { layer.shadowOpacity = newValue }
//    }
//    @IBInspectable
//    var viewShadowOffset: CGSize {
//        get { return layer.shadowOffset }
//        set {layer.shadowOffset = newValue }
//    }
//
//    @IBInspectable var viewCornerRadius: CGFloat {
//        get { return layer.cornerRadius }
//        set {layer.cornerRadius = newValue }
//    }
//    @IBInspectable var maskToBounds: Bool {
//        get { return layer.masksToBounds }
//        set { layer.masksToBounds = newValue }
//    }
//
//    @IBInspectable var borderWidth: CGFloat {
//        get {return layer.borderWidth }
//        set {layer.borderWidth = newValue}
//    }
//
//    @IBInspectable var borderColor: UIColor? {
//        get { return UIColor(cgColor: layer.borderColor!) }
//        set { layer.borderColor = newValue?.cgColor }
//    }
//    @IBInspectable
//    var viewShadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
//}

extension UIView {
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}
extension UIView
{
    func makeSnapshot() -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


public protocol NibLoadable {
    static var nibName: String { get }
}

public extension NibLoadable where Self: UIView {
    
   static var nibName: String {
        return String(describing: Self.self) // defaults to the name of the class implementing this protocol.
    }
    
    static var nib: UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: Self.nibName, bundle: bundle)
    }
    
    func setupFromNib() {
        guard let view = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error loading \(self) from nib") }
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}

extension UIView {
	var isUniquelyHidden: Bool {
		get {
			return self.isHidden
		}
		set {
			if self.isHidden != newValue {
				self.isHidden = newValue
			} 
		}
	}
}

extension UIView {
	func addShadow(shadowOffset: CGSize = CGSize(width: 0.0, height: -0.3),
				   shadowColor: UIColor = UIColor.lightGray,
				   shadowOpacity: CGFloat = 1.0,
				   shadowRadius: CGFloat = 3.0,
				   addCornerRadius: Bool = true,
				   cornerRadius: CGFloat = 0) {
		self.clipsToBounds = false
		let shadow = CAShapeLayer()
		shadow.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
		shadow.shadowColor = shadowColor.cgColor
		shadow.shadowPath = shadow.path
		shadow.shadowOffset = shadowOffset
		shadow.shadowOpacity = Float(shadowOpacity)
		shadow.shadowRadius = shadowRadius
		shadow.shouldRasterize = true
		if addCornerRadius {
			self.layer.cornerRadius = cornerRadius
		}
		self.layer.insertSublayer(shadow, at: 0)
	}
}

extension UIView {
	func createImage(_ color: UIColor) -> UIImage? {
		self.translatesAutoresizingMaskIntoConstraints = false
		self.backgroundColor = color
		
		UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
		self.layer.render(in: UIGraphicsGetCurrentContext()!)
		let img = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return img
	}
}

extension UIView {

	func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
		self.alpha = 0
		self.isHidden = false
		UIView.animate(withDuration: duration!,
					   animations: { self.alpha = 1 },
					   completion: { (value: Bool) in
						  if let complete = onCompletion { complete() }
					   }
		)
	}

	func fadeOut(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
		UIView.animate(withDuration: duration!,
					   animations: { self.alpha = 0 },
					   completion: { (value: Bool) in
						   self.isHidden = true
						   if let complete = onCompletion { complete() }
					   }
		)
	}

}
