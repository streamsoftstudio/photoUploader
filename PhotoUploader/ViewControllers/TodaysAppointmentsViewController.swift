//
//  TodaysAppointmentsViewController.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 9.11.21..
//

import UIKit

class TodaysAppointmentsViewController: UIViewController, StoryboardInitializable {
	var patients: [User] = []
	var filteredPatients: [User] = [] {
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
		filteredPatients = patients
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
		return filteredPatients.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: PatientCell.identifier, for: indexPath) as! PatientCell
		let patient = filteredPatients[indexPath.row]
		cell.configure(patient, index: indexPath.row, of: filteredPatients.count)
		cell.didSelectCamera = {patient in
			print("Start camera for \(patient.userName)")
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
			self.filteredPatients = self.patients
			return
		}
		self.filteredPatients = self.patients.filter {($0.userName.lowercased().contains(textField.text!.lowercased()) ||
													   $0.token.lowercased().contains(textField.text!.lowercased()))}
		
	}
}
