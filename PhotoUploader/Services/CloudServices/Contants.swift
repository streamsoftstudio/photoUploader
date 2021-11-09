//
//  Contants.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import UIKit

struct Constant
{
    enum KeyChain
    {
        static let Service = "com.streamsoftinc.sony360RAmobile-servers"
        static let Host = "com.streamsoftinc.sony360RAmobile-host"
    }
    enum Path
    {
        static let UniversalLink = "sony360RAmobile://immersive-audio.sony.com/start-optimize"
        static let Faq = "https://www.streamsoftinc.com/faq"
        static let SupportPage = "https://streamsoftinc.atlassian.net/servicedesk/customer/portals"

    }
    enum Analytic
    {
        static let APP_START = "app_start"
    }
	enum Env
	{
		static let env = Environment.ENV(rawValue: .dev)
	}
    
    struct AppData
    {
        
        static var host:Host
        {
            return Host(uuid: Constant.AppData.HostId,
                        appVersion:  Constant.AppData.VersionStr,
                        appName: Constant.AppData.AppName,
                        osVersion: Constant.AppData.SystemVersion,
                        platform: Constant.AppData.Platform,
                        model: Constant.AppData.DeviceType)
        }
        
        static var AppName:String {
            return "Sony 360 RA iOS"
        }
        static var HostId:String {
                
            let keychain = Keychain(service: Constant.KeyChain.Host)
            guard let hostId = try? keychain.getString("host_id") else {
                let h = UIDevice.current.identifierForVendor!.uuidString
                try? keychain.set(h, key: "host_id")
                return h
            }
        
           return hostId
        }
        static var VersionStr:String {
            return  "\(Constant.AppData.Version) (\(Constant.AppData.Build))"
        }

        static var Version:String {
            return  Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        }
        static var Build:String {
            return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        }

        static var DeviceType :String {
            return "\(UIDevice.current.model) \(UIDevice.current.systemVersion)"
        }
        static var Language:String {
            return String(Locale.current.identifier.split(separator: "_").first ?? "")
        }
        static var Country:String {
            if let regionCode = Locale.current.regionCode, let language = Locale.current.languageCode {
                return "\(regionCode)/\(language)"
            }
            return ""
        }
        
        static var Platform:String {
            return "iOS"
        }
        static var SystemVersion:String {
            return UIDevice.current.systemVersion
        }
        
        static var DeviceId:String {
            if let uuid = UIDevice.current.identifierForVendor?.uuidString {
                return uuid.hashed() ?? ""
            }
            return ""
        }
    }
}

