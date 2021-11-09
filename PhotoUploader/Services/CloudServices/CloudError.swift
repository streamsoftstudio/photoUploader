//
//  MottoError.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

enum Context
{
    case Login
    case ChangePassword
    case ResetPassword
}
struct ErrorData : Codable, Initializable
{
    init(des:String){
        self.errorDescription = des
        self.error_description = des
        self.message = nil
        self.error = nil
    }
    init() {
        self.init(des: "Error")
    }
    let error:String?
    let message:String?
    let errorDescription:String?
    let error_description:String?
    
    var value:String {
        return errorDescription ?? error_description ?? error ?? message ?? "Error"
    }
}

enum MottoError: Error
{
    case authenticationError(errorData:ErrorData, statusCode:HTTPStatusCode )
    case tenantError
    
    case networkError(code:Int)
    case parsingError(errorData:ErrorData, statusCode:HTTPStatusCode )
    case requestError(errorData:ErrorData)
    
    var statusCode:HTTPStatusCode? {
        switch self
        {
        case .parsingError(_, let statusCode),
             .authenticationError(_, let statusCode):
                return statusCode
        default:
            return nil
        }
    }
    var description:String
    {
        switch (self)
        {
        case .networkError(let code):
            return "networkError".localizedNumber(val: code) ?? "Error"
        case .authenticationError,
             .requestError:
            return "Login error occurred";
        case .parsingError(let errorData, _):
            return errorData.value
        default:
            return "Error"
        }
    }
}
extension Error
{
    var isAuthenticationError:Bool {
        if let s = self as? MottoError {
            guard case .authenticationError = s else {
                return false
            }
            return true
        }
        return false
    }
    var isTenantError:Bool {
        if let s = self as? MottoError {
            guard case .tenantError = s else {
                return false
            }
            return true
        }
        return false
    }
}
