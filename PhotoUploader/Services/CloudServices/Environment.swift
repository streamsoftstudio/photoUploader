//
//  Environment.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

struct Environment {
	enum ENV {
		case prod, dev, qa
		
		init(rawValue: ENV) {
			switch rawValue {
				case .prod: self = .prod
				case .dev: self = .dev
				case .qa: self = .qa
			}
		}
		
		var production: Bool {
			switch self {
				case .prod: return true
				case .dev: 	return false
				case .qa: 	return false
			}
		}
		var authApi: String {
			switch self {
				case .prod: return "https://stg-epm2api.aspendental.com/EpmsAuthentication/oauth2/token"
				case .dev:  return "http://localhost:4200/EpmsAuthentication/oauth2/token"
				case .qa:   return "https://bravo-qa-epmapi.aspendental.com/EpmsAuthentication/oauth2/token"
			}
		}
		
		var clientId: String {
			switch self {
				case .prod: return "epmsApp"
				case .dev:  return "epmsApp"
				case .qa:   return "epmsApp"
			}
		}
		
		var practiceUrl: String {
			switch self {
				case .prod: return "https://stg-epm2api.aspendental.com/EpmsDemographics/api/practice"
				case .dev:  return "http://localhost:4200/EpmsDemographics/api/practice"
				case .qa:   return "https://bravo-qa-epmapi.aspendental.com/EpmsDemographics/api/practice"
			}
		}
		
		var boxIntegrationApi: String {
			switch self {
				case .prod: return "https://prd-fldiisapp.aspendental.com/SmilePhotoUploader/api/box"
				case .dev:  return "http://localhost:4200/api/box"
				case .qa: 	return "https://qa-fldiisapp.aspendental.com/SmilePhotoUploader/api/box"
			}
		}
		
		var p3Url: String {
			switch self {
				case .prod: return "https://p01adepm3iapi.admi.com/ENT.API.Patient/api/PatientAppointment"
				case .dev:  return "https://q01adepm3iapi.admi.com/ENT.API.Patient/api/PatientAppointment"
				case .qa: 	return "https://q01adepm3iapi.admi.com/ENT.API.Patient/api/PatientAppointment"
			}
		}
		
		var arcadUrl: String? {
			switch self {
				case .prod: return "https://arcadphotos-pre-production.azurewebsites.net/"
				case .dev:  return nil
				case .qa: 	return nil
			}
		}
		var arcadToken: String? {
			switch self {
				case .prod: return "8E49FD4F-A759-4B2E-B77B-7B1F02C1C2F7"
				case .dev:  return nil
				case .qa: 	return nil
			}
		}
		
		var arcadCategory: String? {
			switch self {
				case .prod: return "5"
				case .dev:  return nil
				case .qa: 	return nil
			}
		}
		
		var apiKey: String {
			switch self {
				case .prod: return "OHR6H1Q7kXPWQ9o4WdmWTHi9VFGGAHZ3"
				case .dev:  return "OHR6H1Q7kXPWQ9o4WdmWTHi9VFGGAHZ3"
				case .qa: 	return "OHR6H1Q7kXPWQ9o4WdmWTHi9VFGGAHZ3"
			}
		}
		
	}
	
	
}
