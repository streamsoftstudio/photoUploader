//
//  url.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 6/26/21.
//

import UIKit

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
    var hasQuery:Bool {
        let p = self.queryParameters
        return p != nil && !p!.isEmpty
    }
    func query(param: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
    public var schemaHost:String {
        if let scheme = self.scheme, let host = self.host {
            return "\(scheme)://\(host)"
        }
        return ""
    }
    var verifyUrl: Bool {
        return UIApplication.shared.canOpenURL(self)
    }
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
