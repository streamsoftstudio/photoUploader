//
//  BorderedTextField.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 9.11.21..
//

import Foundation
import UIKit

class BorderedTextField: UITextField {
	
	override class func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	
	private func commonInit() {
		self.layer.borderWidth = 2
		self.layer.borderColor = UIColor.mottoGray100.cgColor
		self.layer.cornerRadius = 5.0
	}
}
