//
//  TodaysAppointmentsViewController.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 9.11.21..
//

import UIKit

class TodaysAppointmentsViewController: UIViewController, StoryboardInitializable {
	var appointments: [Appointment] = []
	var filteredAppointments: [Appointment] = [] {
		didSet {
			tableView.reloadData()
		}
	}
	
	@IBOutlet weak var filterTextField: BorderedTextField!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var navigationBar: NavigationBar!
	override func viewDidLoad() {
        super.viewDidLoad()

		navigationBar.delegate = self
		filterTextField.delegate = self
		filteredAppointments = appointments
    }

}

extension TodaysAppointmentsViewController: NavigationBarDelegate {
	func didSelectMenu() {
		print("Menu selected")
	}
}

extension TodaysAppointmentsViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredAppointments.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PatientCell.identifier, for: indexPath) as! PatientCell
		let patient = filteredAppointments[indexPath.row]
		cell.configure(patient, index: indexPath.row, of: filteredAppointments.count)
		cell.didSelectCamera = {patient in
			print("Start camera for \(patient.fullName)")
		}
		return cell
	}
	
	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}
}

extension TodaysAppointmentsViewController: UITextFieldDelegate {
	func textFieldDidChangeSelection(_ textField: UITextField) {
		guard textField.validate != nil else {
			self.filteredAppointments = self.appointments
			return
		}
		self.filteredAppointments = self.appointments.filter {($0.fullName!.lowercased().contains(textField.text!.lowercased())) ||
																("\($0.AccountNumber)".lowercased().contains(textField.text!.lowercased()))}
		
	}
}
