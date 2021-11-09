//
//  uitextfield.swift
//  Sony 360 RA
//
//  Created by Dusan Juranovic on 24.8.21..
//

import UIKit

extension UITextField {
	fileprivate func setPasswordToggleImage(_ button: UIButton) {
		if passwordToggle {
			button.setImage(UIImage(named: "eye_visible")?.withRenderingMode(.alwaysTemplate), for: .normal)
			button.tintColor = visibleColor
		}else{
			button.setImage(UIImage(named: "eye_invisible")?.withRenderingMode(.alwaysTemplate), for: .normal)
			button.tintColor = hiddenColor
		}
	}
	@IBInspectable
	var passwordToggle: Bool {
		get {self.isSecureTextEntry}
		set {
			self.isSecureTextEntry = newValue
			if newValue {
				self.enablePasswordToggle()
			}
		}
	}
	
	var visibleColor: UIColor? {
		get {return .mottoGray900}
	}
	var hiddenColor: UIColor? {
		get {return .mottoGray300}
	}
	
	func enablePasswordToggle(_ viewMode: ViewMode = .whileEditing){
		let button = UIButton(type: .custom)
		setPasswordToggleImage(button)
		button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
		button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
		paddingView.addSubview(button)
		button.center = paddingView.center
		self.rightView = paddingView
		self.rightViewMode = viewMode
	}
	
	func enableLeftImage(_ image: UIImage, color: UIColor) {
		let imageView = UIImageView(image:image)
		imageView.tintColor = color
		imageView.contentMode = .center
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
		paddingView.addSubview(imageView)
		imageView.center = paddingView.center
		self.leftView = paddingView
		self.leftViewMode = .always
	}
	
	func enableRightImage(_ image: UIImage, color: UIColor) {
		let imageView = UIImageView(image:image)
		imageView.tintColor = color
		imageView.contentMode = .center
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
		paddingView.addSubview(imageView)
		imageView.center = paddingView.center
		self.rightView = paddingView
		self.rightViewMode = .always
	}
	
	@objc func togglePasswordView(_ sender: Any) {
		self.isSecureTextEntry.toggle()
		setPasswordToggleImage(sender as! UIButton)
	}
	
	var validate: String? {
		guard let text = self.text, !text.isEmpty else {
			return nil
		}
		return text.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	var validateEmail: String? {
		guard let text = self.text, !text.isEmpty, isValidEmail(text) else {
			return nil
		}
		return text.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	func isValidEmail(_ email: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9-]+\\.[A-Za-z]{2,64}(\\.[A-Za-z]{2,64})?"
		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailPred.evaluate(with: email)
	}
	
	
}

extension UITextView {
	enum Alignment {
		case center, top, bottom
	}
	func alignVertically(_ alignment: Alignment) {
		let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
		let size = sizeThatFits(fittingSize)
		let topOffset = (bounds.size.height - size.height * zoomScale) / 2
		let positiveTopOffset = max(1, topOffset)
		switch alignment {
			case .center: contentOffset.y = -positiveTopOffset
			case .top: contentOffset.y = 10
			case .bottom: contentOffset.y = positiveTopOffset
		}
		
	}
}
