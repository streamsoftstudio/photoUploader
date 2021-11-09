//
//  PatientCell.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 9.11.21..
//

import UIKit

class PatientCell: UITableViewCell, Identifiable {
	@IBOutlet weak var topBorderConstraint: NSLayoutConstraint!
	@IBOutlet weak var bottomBorderConstraint: NSLayoutConstraint!
	@IBOutlet weak var edgeView: UIView!
	@IBOutlet weak var patientNameLabel: UILabel!
	@IBOutlet weak var cameraButton: UIButton!
	var appointment: Appointment!
	var didSelectCamera:((Appointment)->())?
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func configure(_ appointment: Appointment, index: Int, of: Int) {
		self.appointment = appointment
		let joined = appointment.fullName! + " " + "(\(appointment.AccountNumber))"
		patientNameLabel.text = joined
		
		if index == 0 {
			if index == of - 1 {
				addBorders(.all)
			} else {
				addBorders(.top)
			}
		} else if index == of - 1 {
			addBorders(.bottom)
		}
	}

	@IBAction func cameraButtonTapped(_ sender: UIButton) {
		didSelectCamera?(self.appointment)
	}
	
	func addBorders(_ border: Border) {
		self.layer.cornerRadius = 5
		self.edgeView.layer.cornerRadius = 5
		self.clipsToBounds = true
		self.edgeView.clipsToBounds = true
		switch border {
			case .top:
				let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
				self.layer.maskedCorners = maskedCorners
				self.bottomBorderConstraint.constant = 0
				self.layer.maskedCorners = maskedCorners
				self.edgeView.layer.maskedCorners = maskedCorners
			case .bottom:
				let maskedCorners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
				self.layer.maskedCorners = maskedCorners
				self.bottomBorderConstraint.constant = 2
				self.layer.maskedCorners = maskedCorners
				self.edgeView.layer.maskedCorners = maskedCorners
			case .all:
				let maskedCorners: CACornerMask = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
				self.layer.maskedCorners = maskedCorners
				self.bottomBorderConstraint.constant = 2
				self.layer.maskedCorners = maskedCorners
				self.edgeView.layer.maskedCorners = maskedCorners
				
		}
	}
	
	enum Border {
		case top, bottom, all
	}
}
