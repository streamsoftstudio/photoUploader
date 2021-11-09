//
//  DatabaseServices.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

protocol ServerDatabase
{
    var serverToken:SignUpData? { get set}
    var baseURL: String { get set }
}
protocol UserDatabase
{
    var Username:String { get set }
    var Password:String { get set }
    var Office:String { get set }
}


class DatabaseServices
{
    private var serverDatabase:ServerDatabase!
    private var userDatabase:UserDatabase!
    
    private init() {}
    
    private func setup() {
        let storage = StorageContextImpl.create(engine: .UserDefaults)
        self.serverDatabase = ServerDatabaseImpl(storage: storage)
        self.userDatabase = UserDatabaseImpl(storage: storage)
    }
    
    private static var database: DatabaseServices = {
        let rec = DatabaseServices()
        rec.setup()
        return rec
    }()
    
    class func shared() -> DatabaseServices {
        return database
    }

    var server:ServerDatabase {
        return self.serverDatabase
    }
    var user:UserDatabase {
        return self.userDatabase
    }
}

