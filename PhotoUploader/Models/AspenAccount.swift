//
//  AspenAccount.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

struct AspenAccount: Codable {
	var patientCode: String
	var anglePhotos: [AnglePhoto]
	var complete: Bool
	var digiAct: String
	var accountNumber: String
	var firstName: String
	var lastName: String
}
