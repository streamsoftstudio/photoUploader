//
//  PatientCell.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 9.11.21..
//

import UIKit

class PatientCell: UITableViewCell, Identifiable {

	@IBOutlet weak var patientNameLabel: UILabel!
	@IBOutlet weak var cameraButton: UIButton!
	var patient: User!
	var didSelectCamera:((User)->())?
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	func configure(_ patient: User) {
		self.patient = patient
		let joined = patient.userName + " " + "(\(patient.token))"
		patientNameLabel.text = joined
		
		self.layer.borderWidth = 1.0
		self.layer.borderColor = UIColor.mottoGray700.withAlphaComponent(0.2).cgColor
		self.layer.cornerRadius = 3.0
	}

	@IBAction func cameraButtonTapped(_ sender: UIButton) {
		didSelectCamera?(self.patient)
	}
}
