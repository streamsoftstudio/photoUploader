//
//  coding.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 7/8/21.
//

import Foundation


extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
    var sdictionary: [String: String] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        
        if let o = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
            return o.compactMapValues { $0 as? String }
        }
        return [:]
    }
    
}
func initializeObject<T: Initializable>(fromType type: T.Type) -> T {
    return T.init()
}
protocol Initializable : Decodable {
    init()
}
extension Decodable {
    
    static func decoded(str: String) -> Self? {
        if let data =  str.data(using: .utf8), let val = try? JSONDecoder().decode( Self.self, from:data) {
            return val
        }
        return nil
    }
}
extension Encodable {
    var encoded:String {
        if let e = try? JSONEncoder().encode(self), let val = String(data:e, encoding: .utf8) {
            return val
        }
        return ""
    }
}

extension Decodable {
    static func decode(data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }

    static func sdecode(str:String) throws -> Self {
        return try decode(data: (str.data(using: .utf8) ?? Data()) )
    }
}

extension Initializable {
    static func create(data:Data) -> Self {
        return (try? decode(data: data)) ??  Self.self.init()
    }
}

extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try? encoder.encode(self)
    }
    func sencode() -> String {
        return (try? String(data: encode() ?? Data(), encoding: .utf8)) ?? ""
    }
}
