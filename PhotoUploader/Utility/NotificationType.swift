//
//  NotificationType.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//


import Foundation

enum NotificationType {
	case error(MottoError)
	case info(String, String? = nil)
	case notif(String, String? = nil)
	
	var display: String {
		switch self {
			case .error(let error):
				switch error {
					case .requestError(errorData: _): return "Request error occured"
					case .authenticationError(errorData: _, statusCode: let statusCode): return"Authentication error occured - \(statusCode)"
					case .networkError(code: let code): return "Network error occured - \(code)"
					case .parsingError(errorData: let errorData, statusCode: _):
						let errorMessage = errorData.errorDescription ?? errorData.error_description
						switch errorMessage {
							case "User is disabled": return "missing_verification".localized
							case "Bad credentials": return "unknown_user".localized
							case "Old and new password must not match": return "old_new_pass_match".localized
							case "Provided old password does not match.": return "bad_old_pass".localized
							case "User already exists.": return "user_exists".localized
							default: return "Unknown Error"
						}
					case .tenantError:
						return "Tenant error occured"
				}
			case .info(let string, let arg): return string.localizedString(val: arg ?? "")
			case .notif(let string, let arg): return string.localizedString(val: arg ?? "")
		}
	}
}
