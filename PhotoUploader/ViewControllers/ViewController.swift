//
//  ViewController.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import UIKit

class ViewController: UIViewController {
	var networkServices: NetworkServices!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		self.networkServices = NetworkServices()
	}
	
	//Office
	func getFacilityCodeByIp() {
		self.networkServices.getFacilityCodeByIp { result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Got FacilityCode by IP")
			}
		}
	}
	func getEnvironmentByFacilityCode(_ code: String) {
		self.networkServices.getEnvironmentByFacilityCode(code) { result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Got ENV by Facility code")
			}
		}
	}
	func getOffices() {
		self.networkServices.getOffices { result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Got Offices")
			}
		}
	}
	func getOfficeCodeByIp() {
		self.networkServices.getOfficeCodeByIp { result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Got OfficeCode by IP")
			}
		}
	}
	func getAppointments(facilityCode: String) {
		self.networkServices.getAppointments(facilityCode: facilityCode) {result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Got OfficeCode by IP")
			}
		}
	}
	func getIsOfficeinP3(facilityCode: String) {
		self.networkServices.getIsOfficeinP3(facilityCode: facilityCode) { result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Got isOffice in P3")
			}
		}
	}
	func getAppointmentsP3(facilityCode: String) {
		self.networkServices.getAppointmentsP3(facilityCode: facilityCode) { result in
			switch result {
				case .failure(let error): print(error)
				case .success(_):
					print("Got appointments in P3")
			}
		}
	}
	
	//Patients
	func search(accountNumber: String) {
		let config = QueryConfig(accNumber: "123456", fetch: "10", filter: "1", offset: "0", sortColumn: "Name", sortDirection: "ASC")
		self.networkServices.searchAccountNumber(queryConfig: config) { result in
			switch result {
				case .failure(let error): print(error)
				case .success(let accountNumber):
					print("Got AccountNumber: \(accountNumber)")
			}
		}
	}
	
	func getDigiAct(accountNumber: String, patientCode: String) {
		self.networkServices.getDigiAct(accountNumber: accountNumber, patientCode: patientCode) { result in
			switch result {
				case .failure(let error): print(error)
				case .success(let accountNumber):
					print("Got DigiAct: \(accountNumber)")
			}
		}
	}
	
	@IBAction func getFacilityByIpAction(_ sender: UIButton) {
		getFacilityCodeByIp()
	}
	@IBAction func getEnvByFacCode(_ sender: UIButton) {
		getEnvironmentByFacilityCode("Office")
	}
	@IBAction func getOfficesAction(_ sender: UIButton) {
		getOffices()
	}
	
	@IBAction func getOfficeCodeByIpAction(_ sender: UIButton) {
		getOfficeCodeByIp()
	}
	
	@IBAction func getAppointments(_ sender: UIButton) {
		getAppointments(facilityCode: "OfficeCode")
	}
	
	@IBAction func getIsOfficeInP3(_ sender: UIButton) {
		getIsOfficeinP3(facilityCode: "OfficeCode")
	}
	
	@IBAction func getAppointmentsP3(_ sender: UIButton) {
		getAppointmentsP3(facilityCode: "OfficeCode")
	}
	@IBAction func searchAction(_ sender: UIButton) {
		search(accountNumber: "AccNumber")
	}
	@IBAction func getDigiActAction(_ sender: UIButton) {
		getDigiAct(accountNumber: "AccNumber", patientCode: "PatientCode")
	}
}

