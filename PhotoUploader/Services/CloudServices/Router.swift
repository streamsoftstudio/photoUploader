//
//  Router.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

struct NetworkConstants
{
    public enum HTTPMethod : String
    {
        case options
        case get
        case head
        case post
        case put
        case patch
        case delete
        case trace
        case connect
    }
    enum HTTPHeaderField: String
    {
        case authentication = "Authorization"
        case contentType    = "Content-Type"
        case acceptType     = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String
    {
        case json = "application/json"
        case form = "application/x-www-form-urlencoded"
    }
    
    enum App: String
    {
        case Token = "Basic Y29uc3VtZXJfaW9zOmhhbmRiYWxsMjAxNQ=="
    }
}
protocol ServerEndpoints
{
    var path: String { get }
    var body: Data? { get }
    var method: NetworkConstants.HTTPMethod { get }
    var useBearer: Bool? { get }
	var query: [URLQueryItem]? { get }
}

enum OfficeEndpoints: ServerEndpoints {
	case getFacilityCodeByIp
	case getEnvironmentByFacilityCode(_ code: String)
	case getOffices
	case getOfficeCodeByIp
	case getAppointments(facilityCode: String)
	case getIsOfficeinP3(facilityCode: String)
	case getAppointmentsP3(facilityCode: String)
	
	var path: String {
		switch self {
			case .getFacilityCodeByIp: 					  	 return "/facility/getbyip"
			case .getEnvironmentByFacilityCode(let code): 	 return "/facility/getbyip?facilitycode=\(code)"
			case .getOffices: 							  	 return "/office?code=&name=&description=&offset=0&fetch=2147483647&sortColumn=Code&sortDirection=ASC"
			case .getOfficeCodeByIp:					  	 return "/office/ipaddress"
			case .getAppointments(facilityCode: let code):   return "/AppointmentBook/PatientsForTodaysAppointments/\(code)"
			case .getIsOfficeinP3(facilityCode: let code):	 return "/facility/getbyip"
			case .getAppointmentsP3(facilityCode: let code): return "/TodaysPatientsAppointments/\(code)"
		}
	}
	
	var body: Data? {
		switch self {
			default: return Data()
		}
	}
	
	var method: NetworkConstants.HTTPMethod {
		switch self {
			default: return .get
		}
	}
	
	var useBearer: Bool? {
		switch self {
			default: return true
		}
	}
	
	var query: [URLQueryItem]? {
		return nil
	}
}

struct QueryConfig: Codable {
	let accNumber: String
	let fetch: String
	let filter: String
	let offset: String
	let sortColumn: String
	let sortDirection: String
}

enum PatientEndpoints: ServerEndpoints {
	case searchAccountNumber(accountNumber: QueryConfig)
	case getDigiAct(accountNumber: String, patientCode: String)
	
	var path: String {
		switch self {
			case .searchAccountNumber(_):					  return "/patient/search"
			case .getDigiAct(let accNumber, let patientCode): return "/account/getDigiactId/\(accNumber)/\(patientCode)"
		}
	}
	
	var body: Data? {
		switch self {
			default: return Data()
		}
	}
	
	var method: NetworkConstants.HTTPMethod {
		switch self {
			case .searchAccountNumber(_): return .post
			case .getDigiAct(_, _): 	  return .get
		}
	}
	
	var useBearer: Bool? {
		switch self {
			default: return true
		}
	}
	
	var query: [URLQueryItem]? {
		switch self {
			case .searchAccountNumber(accountNumber: let config):
				let filterObject = ["\(config.filter)":"\(config.accNumber)"].encoded
				let filter = URLQueryItem(name: "filter", value: filterObject)
				let fetch = URLQueryItem(name: "fetch", value: config.fetch)
				let offset = URLQueryItem(name: "offset", value: config.offset)
				let sortColumn = URLQueryItem(name: "sortColumn", value: config.sortColumn)
				let sortDirection = URLQueryItem(name: "sortDirection", value: config.sortDirection)
				return [fetch, filter, offset, sortColumn, sortDirection]
			default: return nil
		}
	}
}

enum AuthEndpoints : ServerEndpoints
{
	case login(username:String, password:String, office:String)
    case refresh(token:String)
    case forgot(email:String)
    case reset(password:String, token:String)
    case change(oldPassword:String, newPassword:String)
    case logout(email:String)
    case token(token:String)
    case get
    
    var path: String
    {
        switch self
		{
			case .login: 			  return ""
			case .refresh(let token): return "/oauth/token?grant_type=refresh_token&refresh_token=\(token)&host=\(Constant.AppData.host.uuid)"
			case .forgot(let email):  return "/endUser/forgotPassword?email=\(email.addingPercentEncoding(withAllowedCharacters:.rfc3986Unreserved)!)"
			case .reset:              return "/endUser/resetPassword"
			case .change:             return "/endUser/changePassword"
			case .logout:             return "/endUser/logout"
			case .token(let token):   return "/endUser/fcmToken?token=\(token)"
			case .get:                return "/endUser/get"
		}
    }
	var body: Data? {
		switch self {
			case .reset(let password, let token):
				return NewPassword(newPassword:password, token:token).encode()
			case .change(let oldPassword, let newPassword):
				return  ChangePassword(oldPassword:oldPassword, newPassword:newPassword).encode()
			case .login(_, _, _):
				return Constant.AppData.host.encode()
			case .get,
				 .logout,
				 .token,
				 .forgot,
				 .refresh:
				return Data() // empty body
		}
	}
    var method: NetworkConstants.HTTPMethod {
        switch self {
        case .logout,
             .token,
             .reset,
             .change,
             .refresh,
             .login: return .post
        case .get,
             .forgot: return .get
        }
    }
    
    var useBearer: Bool? {
        switch self {
        case .forgot,
             .reset,
             .refresh,
             .login: return false
        case .get,
             .logout,
             .change,
             .token: return true
        }
    }
	
	var query: [URLQueryItem]? {
		switch self {
			case .login(let username, let password, let office):
				let encodedPassword = password.encoded
				
				let grantType = URLQueryItem(name: "grant_type", value: "password")
				let username = URLQueryItem(name: "username", value: username)
				let password = URLQueryItem(name: "password", value: encodedPassword)
				let clientId = URLQueryItem(name: "client_id", value: Constant.Env.env.clientId)
				let facilityCode = URLQueryItem(name: "facility_code", value: office)
				return [grantType, username, password, clientId, facilityCode]
			default: return nil
		}
	}
}

enum UploadEndpoints: ServerEndpoints {
	case uploadPhotos(acc: AspenAccount, office: String)
	case createFolders(acc: AspenAccount, office: String)
	case checkFilesExist(digiActId: String, timestamp: String, officeId: String, baseIP: String)
	case uploadPhotoSingle(acc:AspenAccount, office: String)
	
	var path: String {
		switch self {
			case .uploadPhotos(_, _):
				return ""
			case .createFolders(let acc, let office):
				return "/createfolders/\(office)/\(acc.digiAct)/\(Constant.Env.env.apiKey)"
			case .checkFilesExist(let digiActId, let timestamp, let officeId, let baseIP):
				return "/fileuploaded/\(digiActId)/\(timestamp)/\(officeId)/\(baseIP)/\(Constant.Env.env.apiKey)}"
			case .uploadPhotoSingle(_, _):
				return "/uploadsingle"
		}
	}
	
	var body: Data? {
		switch self {
			case .uploadPhotos(let acc, let office):
				let upload = AnglePhotosUpload(digiActID: acc.digiAct, rootFolderId: nil, rootFolderName: nil, facilityCode: office, apiKey: Constant.Env.env.apiKey, ipOctets: nil, anglePhotos: [])
				do {
					let data = try JSONEncoder().encode(upload)
					return data
				} catch {
					print("Could not encode AnglePhotosUpload")
					return nil
				}
			case .uploadPhotoSingle(let acc, let office):
				let upload = AnglePhotosUpload(digiActID: acc.digiAct, rootFolderId: nil, rootFolderName: nil, facilityCode: office, apiKey: Constant.Env.env.apiKey, ipOctets: nil, anglePhotos: [])
				do {
					let data = try JSONEncoder().encode(upload)
					return data
				} catch {
					print("Could not encode AnglePhotosUpload")
					return nil
				}
			default: return Data()
		}
	}
	
	var method: NetworkConstants.HTTPMethod {
		switch self {
			case .uploadPhotos,
				 .uploadPhotoSingle: return .post
			default: return .get
		}
	}
	
	var useBearer: Bool? {
		switch self {
			default: return true
		}
	}
	
	var query: [URLQueryItem]? {
		switch self {
			default: return nil
		}
	}
}
