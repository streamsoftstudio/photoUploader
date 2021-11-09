//
//  Appointment.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 9.11.21..
//

import Foundation

struct Appointment: Codable {
	var DigiAct: Int
	var FirstName: String
	var LastName: String
	var AccountNumber: Int
	var PatientCode: String
	
	var fullName: String? {
		return FirstName + " " + LastName
	}
}
