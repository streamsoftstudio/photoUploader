//
//  button.swift
//  Sony 360 RA
//
//  Created by Dusan Juranovic on 15.9.21..
//

import UIKit

extension UIButton {
	func underline() {
		let attributes: [NSAttributedString.Key: Any] = [
			.underlineStyle: NSUnderlineStyle.single.rawValue,
			.font: (self.titleLabel?.font)!,
			.foregroundColor: (self.titleLabel?.textColor)!
		]
		let attributedText = NSAttributedString(string: (self.titleLabel?.text!)!,
												attributes: attributes)
		self.setAttributedTitle(attributedText, for: .normal)
	}
}
