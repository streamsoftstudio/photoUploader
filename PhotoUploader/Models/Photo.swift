//
//  Photo.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

struct Photo: Codable {
	let base64string: String
	let size: Double
	let name: String
}

struct PhotoUpload: Codable {
	let digiact: Double
	let files: [Photo]
}
