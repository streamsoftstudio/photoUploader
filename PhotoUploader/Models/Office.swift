//
//  Office.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

struct Office: Codable {
	var Code: String
	var Name: String
	var ShortName: String?
	var AddressId: Int
	var Address: Address
	var PhoneNumber: String
	var FaxNumber: String
	var BusinessId: Int
	var Distance: Int
	var TimeZone: String
	var TimeZoneOffset: Int
	var TimeZoneDSTOffset: Int
	var HonorsDaylightSavings: Bool
	var IsInvisalign: Bool
	var InvisalignDate: String?
	var StatusId: Int
	var Status: Int?
	var FirstThreeOctets: String
	var Faccode: Int?
	
	var display: String? {
		return Code + " - " + Name
	}
}

struct Address: Codable {
	var Id: Int
	var TypeId: Int
	var `Type`: Int?
	var Line1: String
	var Line2: String
	var Line3: String
	var City: String
	var StateId: Int
	var State: State
	var ZipCode: String
	var ZipExtension: String
	var Instructions: String
	var Comments: String
	var IsRequired: Bool
	var StatusId: Int
	var Status: Int?
	var UserName: String
	var IsEmpty: Bool
}

struct State: Codable {
	var Id: Int
	var CountryId: Int
	var Country: Int?
	var Abbreviation: String
	var Name: String
	var StatusId: Int
	var Status: Int?
}
