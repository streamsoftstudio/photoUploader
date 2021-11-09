//
//  AnglePhoto.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation
import UIKit

struct AnglePhotosUpload: Codable {
  var digiActID: String
  var rootFolderId: String?
  var rootFolderName: String?
  var facilityCode: String
  var apiKey: String
  var ipOctets: String?
  var anglePhotos: [AnglePhoto]
}

struct AnglePhoto: Codable {
	var angleName: String
	var photoInBase64: String
	var rotated: Bool = false
	var directions: String
	var dataUrl: String
	var overlaySrc: String
	var uploaded: Bool = false
	var promptToRotate: Bool = false
	
	init(config:ConfigItem) {
		self.angleName = config.angleName
		self.photoInBase64 = ""
		self.overlaySrc = config.overlayImage
		self.promptToRotate = config.promptToRotate
		self.directions = ""
		self.dataUrl = ""
	}
}

struct ConfigItem: Codable {
	var angleName: String
	var overlayImage: String
	var promptToRotate: Bool
	var directions: String
}
