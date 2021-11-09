//
//  DatabaseImpl.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

enum DatabaseEngine
{
    case UserDefaults
    case Realm
}

class StorageContextImpl : StorageContext {
    
    
    static public func create( engine: DatabaseEngine ) ->  StorageContext {
        switch engine
        {
        case .Realm:            return StorageContextRealmImpl()
        case .UserDefaults:     return StorageContextUserDefaultsImpl()
        }
    }
    
    func create<T>(_ model: T.Type, value: Any, completion: @escaping ((T) -> Void)) throws where T : Storable {
        
    }
    
    func save<T>(object: T) where T : Storable {
        
    }
    
    func update(block: @escaping () -> ()) throws {
        
    }
    
    func delete(object: Storable) throws {
        
    }
    
    func deleteAll<T>(_ model: T.Type) throws where T : Storable {
        
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, defaultValue: T, completion: @escaping (([T]) -> ())) where T : Storable {
        
    }
    
    func observe<T>(_ type: T.Type, changed: @escaping (() -> ())) throws where T : Storable {
    }
    
}

class StorageContextUserDefaultsImpl : StorageContextImpl
{
    override func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ())) where T : Storable {
        
    }
    
    override func fetch<T>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, defaultValue: T, completion: @escaping (([T]) -> ())) where T : Storable {
       
        let k = "\(model)"
        let o = try?  UserDefaults.standard.get(objectType: model, forKey: k)
        
        completion( o != nil ? [o!] : [defaultValue])
    }
    override func save<T>(object: T) where T : Storable {

        let k = "\(type(of:object))"

        try? UserDefaults.standard.set(obj: object, forKey: k )
    }
}
class StorageContextRealmImpl : StorageContextImpl
{

}
