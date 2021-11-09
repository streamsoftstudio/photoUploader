//
//  uilabel.swift
//  iOSExtensions
//
//  Created by Dusan Juranovic on 28.8.21..
//

import UIKit

public extension UILabel {
	/// A simple ellipsis animation extension on UILabel.
	/// - Parameters:
	///   - string: `UILabel` text on which ellipsis animation will be added.
	///   - timeInterval: `timeInterval` between each ellipsis element drawing. Defaults to 0.5.
	///   - ellipsisSymbol: `String` symbol to use for ellipsis elements. Defaults to a `dot` (`.`).
	///   - ellipsisCount: number of ellipsis elements to animate. Defaults to 3.
	func animateEllipsis(_ string: String, timeInterval: TimeInterval = 0.5, ellipsisSymbol: String = ".", ellipsisCount: Int = 3) {
		self.text = string
		var index = 1
		
		Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { timer in
			if self.text!.prefix(string.count) != string {
				timer.invalidate()
			} else {
				self.text = string.appending(Array(repeating: ellipsisSymbol, count: index).joined())
				index += 1
				index = index % (ellipsisCount + 1)
			}
		}
	}
	
	internal func displayNotification(_ type: NotificationType, animateEllipsis: Bool = false, timeInterval:TimeInterval = 0.5, ellipsisSymbol: String = " ●", ellipsisCount: Int = 3) {
		if animateEllipsis {
			self.animateEllipsis(type.display, timeInterval: timeInterval, ellipsisSymbol: ellipsisSymbol, ellipsisCount: ellipsisCount)
		}
		self.isUniquelyHidden = false
		self.text = type.display
		switch type {
			case .info:
				self.textColor = .white
			case .error:
				self.textColor = .red
			case .notif:
				self.textColor = .green
		}
	}
	
	/// Changes `UILabel` text with a `.transitionCrossDissolve` animation
	/// - Parameter title: New String to use for a `text` property of `UILabel`
	/// - Parameter duration: Animation duration. Defaults to `0.5`.
	internal func transition(to title: String, duration: TimeInterval = 0.5) {
		UIView.transition(with: self, duration: duration, options: .transitionCrossDissolve) { [weak self] in
			self?.text = title.localized
		}
	}
}
