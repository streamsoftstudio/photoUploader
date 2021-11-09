//
//  userdefaults.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 7/13/21.
//

import Foundation

public extension UserDefaults {


    func set<T: Codable>(obj: T, forKey: String) throws {

        let jsonData = try JSONEncoder().encode(obj)

        set(jsonData, forKey: forKey)
    }

    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {

        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }

        return try JSONDecoder().decode(objectType, from: result)
    }
}
