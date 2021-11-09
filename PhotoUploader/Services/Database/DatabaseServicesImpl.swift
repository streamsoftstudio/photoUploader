//
//  DatabaseServicesImpl.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

struct UserDatabaseImpl: UserDatabase
{
    var storage: StorageContext?
    init(storage:StorageContext?) {
        self.storage = storage
    }
    
    var Username:String
    {
        get { return user.Username }
        set {user.Username = newValue }
    }
    var Password:String
    {
        get { return user.Password }
        set {user.Password = newValue }
    }
    var Office:String
    {
        get { return user.Office }
        set {user.Office = newValue }
    }
    
    private var user:UserEntity
    {
        get
        {
            var ret = UserEntity()
            self.storage?.fetch(UserEntity.self, predicate: nil, sorted: nil, defaultValue: ret, completion: { w in
                ret = w.first!
            });

            return ret
        }
        set
        {
            self.storage?.save(object: newValue)
        }
    }
}
struct ServerDatabaseImpl : ServerDatabase
{
    var storage: StorageContext?
    init(storage:StorageContext?) {
        self.storage = storage
    }
    private var server:ServerEntity
    {
        get
        {
            var ret = ServerEntity()
            self.storage?.fetch(ServerEntity.self, predicate: nil, sorted: nil, defaultValue: ret, completion: { w in
                ret = w.first!
            });

            return ret
        }
        set
        {
            self.storage?.save(object: newValue)
        }
    }
    

    var baseURL: String
    {
        get {
            return server.baseUrl
        }
        set {
            server.baseUrl = newValue
        }
    }
   
    public var serverToken:SignUpData?
    {
        get {
            return server.serverToken
        } set {
            self.server.serverToken = newValue
        }
    }
}
