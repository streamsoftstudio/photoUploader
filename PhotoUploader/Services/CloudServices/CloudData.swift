//
//  CloudData.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation
import UIKit


struct SignUpData : Codable
{
    let access_token:String
    let token_type:String
    let refresh_token:String
    let expires_in: Int
    let scope:String
}

struct Host : Codable
{
    let uuid:String
    let appVersion:String
    let appName:String
    let osVersion:String
    let platform:String
    let model:String
}


// Tenant
struct ID: Codable
{
    let id:Int
}

struct NewPassword : Codable
{
    let newPassword:String
    let token:String
}

struct ChangePassword: Codable
{
    let oldPassword:String
    let newPassword:String
}

enum EndUserType: String, Codable
{
    case SIGNED_UP
}
struct UserData: Codable
{
    let enabled:Bool?
    let id:Int?
    let firstName:String?
    let lastName:String?
    let endUserType:EndUserType?
}

////
public protocol EmptyResponse {
    static func emptyValue() -> Self
}

/// A type representing an empty response. Use `Empty.value` to get the instance.
public struct Empty: Decodable {
    public static let value = Empty()
}

extension Empty: EmptyResponse {
    public static func emptyValue() -> Empty {
        return value
    }
}

