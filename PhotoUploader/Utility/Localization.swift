//
//  Localization.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//


import UIKit

protocol Localizable {
    var localized: String { get }
}
extension String: Localizable
{
    static var Language:String {

        var l = String(Locale.current.identifier.split(separator: "_").first ?? "en")
        
        let simplified = ["zh", " zh-CHS" , "zh_CHS", "zh-Hans", "zh_Hans", "zh-CN", "zh_CN", "zh-SG", "zh_SG"]
        if simplified.contains(l) {
            l = "zh-Hans"
        }
        
        let traditional = ["zh-CHT", "zh_CHT" , "zh-Hant", "zh_Hant", "zh-HK", "zh_HK", "zh-MO", "zh_MO", "zh-TW", "zh_TW"]
        if traditional.contains(l){
            l = "zh-Hant"
        }
        
        return l
    }
    var localized: String {
        
        var path = Bundle.main.path(forResource:  String.Language , ofType: "lproj")
        if path == nil {
            path = Bundle.main.path(forResource: "en" , ofType: "lproj")
        }
        guard let p = path else {
            return self
        }
  
        let bundle = Bundle(path: p)!
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    func localizedNumber(val:Int) -> String? {
        return String.localizedStringWithFormat(self.localized, val)
    }
    func localizedNumber(val:Float) -> String? {
        return String.localizedStringWithFormat(self.localized, val)
    }
    func localizedString(val:String) -> String {
        return String.localizedStringWithFormat(self.localized, val)
    }
    func localizedStrings(val1:String, val2:String) -> String {
        return String.localizedStringWithFormat(self.localized, val1, val2)
    }
    var english:String {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bundle = Bundle(path: path!)!
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    func englishWithNumber(val:Int) -> String? {
        return String.localizedStringWithFormat(self.english, val)
    }
}

protocol XIBLocalizable {
    var xibLocKey: String? { get set }
}

extension UITabBarItem: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get{ return nil}
        set(key) {
            title = key?.localized
        }
    }
}
extension UILabel: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized
        }
    }
}
extension UIButton: XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized, for: .normal)
        }
    }
}
extension UITextField:XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.placeholder = key?.localized
        }
    }
}

extension UIBarButtonItem:XIBLocalizable {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            self.title = key?.localized
        }
    }
}


