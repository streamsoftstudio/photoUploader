//
//  NetworkServices.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

protocol ResultData: Codable {}

struct AuthResponse: ResultData {
	var authorized: Bool
}

struct VoidResponse: ResultData {}

struct OfficeResponse: ResultData {
	var offices: [Office]
}
struct PatientResponse: ResultData {
	var name: String
	var account: AspenAccount
}

class NetworkServices {
	//Authorization
	func auth(username: String, password: String, office: String, _ completion:@escaping(Result<AuthResponse, Error>)->()) {
		execute(with: AuthEndpoints.login(username: username, password: password, office: office), baseUrl: Constant.Env.env.authApi, completion: completion)
	}
	
	//Offices
	func getFacilityCodeByIp(_ completion:@escaping(Result<VoidResponse, Error>)->()) {
		execute(with: OfficeEndpoints.getFacilityCodeByIp, baseUrl: Constant.Env.env.authApi, completion: completion)
	}
	func getEnvironmentByFacilityCode(_ code: String, _ completion:@escaping(Result<OfficeResponse, Error>)->()) {
		execute(with: OfficeEndpoints.getEnvironmentByFacilityCode(code), baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	func getOffices(_ completion:@escaping(Result<OfficeResponse, Error>)->()) {
		execute(with: OfficeEndpoints.getOffices, baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	func getOfficeCodeByIp(_ completion:@escaping(Result<OfficeResponse, Error>)->()) {
		execute(with: OfficeEndpoints.getOfficeCodeByIp, baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	func getAppointments(facilityCode: String, _ completion:@escaping(Result<OfficeResponse, Error>)->()) {
		execute(with: OfficeEndpoints.getAppointments(facilityCode: facilityCode), baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	func getIsOfficeinP3(facilityCode: String, _ completion:@escaping(Result<OfficeResponse, Error>)->()) {
		execute(with: OfficeEndpoints.getIsOfficeinP3(facilityCode: facilityCode), baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	func getAppointmentsP3(facilityCode: String, _ completion:@escaping(Result<OfficeResponse, Error>)->()) {
		execute(with: OfficeEndpoints.getAppointmentsP3(facilityCode: facilityCode), baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	
	//Patients
	func searchAccountNumber(queryConfig: QueryConfig, _ completion:@escaping(Result<PatientResponse, Error>)->()) {
		execute(with: PatientEndpoints.searchAccountNumber(accountNumber: queryConfig), baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	func getDigiAct(accountNumber: String, patientCode: String, _ completion:@escaping(Result<PatientResponse, Error>)->()) {
		execute(with: PatientEndpoints.getDigiAct(accountNumber: accountNumber, patientCode: patientCode), baseUrl: Constant.Env.env.practiceUrl, completion: completion)
	}
	
	//Upload
	func createFolders(acc: AspenAccount, office: String, _ completion:@escaping(Result<VoidResponse, Error>)->()) {
		execute(with: UploadEndpoints.createFolders(acc: acc, office: office), baseUrl: Constant.Env.env.boxIntegrationApi, completion: completion)
	}
	
	func checkFilesExist(digiActId: String, timestamp: String, officeId: String, baseIP: String, _ completion:@escaping(Result<VoidResponse, Error>)->()) {
		execute(with: UploadEndpoints.checkFilesExist(digiActId: digiActId, timestamp: timestamp, officeId: officeId, baseIP: baseIP), baseUrl: Constant.Env.env.boxIntegrationApi, completion: completion)
	}
	
	func uploadPhotoSingle(acc: AspenAccount, office: String, _ completion:@escaping(Result<VoidResponse, Error>)->()) {
		execute(with: UploadEndpoints.uploadPhotoSingle(acc: acc, office: office), baseUrl: Constant.Env.env.boxIntegrationApi, completion: completion)
	}
	
	
	private func execute<T: Codable>(with endpoint:ServerEndpoints, baseUrl:String, completion:@escaping(Result<T, Error>)->()) {
		guard let url = URL(string: "\(baseUrl)\(endpoint.path)") else {
			completion(.failure(MottoError.authenticationError(errorData: ErrorData(des: "Wrong endpoint"), statusCode: .badRequest)))
			return
		}
		
		var headers: [String: String] = [
			NetworkConstants.HTTPHeaderField.contentType.rawValue: NetworkConstants.ContentType.form.rawValue
		]
		
		headers[NetworkConstants.HTTPHeaderField.authentication.rawValue] = NetworkConstants.App.Token.rawValue
		
		var urlComponents = URLComponents(string: url.absoluteString)
		urlComponents?.queryItems = endpoint.query
		let finalUrl = urlComponents?.url
		
		var request = URLRequest(url: finalUrl!)
		request.httpMethod = endpoint.method.rawValue
		request.httpBody = endpoint.body
		
		headers.forEach { (key,val) in  request.addValue(val, forHTTPHeaderField: key) }
		
		let config = URLSessionConfiguration.default
		config.allowsCellularAccess = true
		
		let urlSession = URLSession(configuration: config)
		urlSession.dataTask(with: request) { data, response, error in
			guard error == nil else {
				print("An error occured \(error)")
				return
			}
			
			guard let data = data else {
				print("No data returned")
				return
			}
			let decoder = JSONDecoder()
			do {
				let result = try decoder.decode(T.self, from: data)
				completion(.success(result))
			} catch {
				completion(.failure(MottoError.parsingError(errorData: ErrorData(des: "Could not parse data"), statusCode: .failedDependency)))
			}
			
		}.resume()
	}
}
