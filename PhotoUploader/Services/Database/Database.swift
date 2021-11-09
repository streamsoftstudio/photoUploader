//
//  Database.swift
//  PhotoUploader
//
//  Created by Dusan Juranovic on 8.11.21..
//

import Foundation

public protocol Storable : Codable {}

/* Query options */
public struct Sorted
{
    var key: String
    var ascending: Bool = true
}

/*
 Operations on context
 */
protocol StorageContext
{
    /*
     Create a new object with default values
     return an object that is conformed to the `Storable` protocol
     */
    func create<T: Storable>(_ model: T.Type, value: Any , completion: @escaping ((T) -> Void)) throws
    /*
     Save an object that is conformed to the `Storable` protocol
     */
    func save<T: Storable>(object: T)
    /*
     Update an object that is conformed to the `Storable` protocol
     */
    func update(block: @escaping () -> ()) throws
    /*
     Delete an object that is conformed to the `Storable` protocol
     */
    func delete(object: Storable) throws
    /*
     Delete all objects that are conformed to the `Storable` protocol
     */
    func deleteAll<T: Storable>(_ model: T.Type) throws
    /*
     Return a list of objects that are conformed to the `Storable` protocol
     */
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, completion: (([T]) -> ()))
    
    /*
     Return a list of objects that are conformed to the `Storable` protocol. Else default
     */
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?, defaultValue:T, completion: @escaping (([T]) -> ()))
    
    /*
     hook to observe changes for specific object
     */
    func observe<T: Storable>(_ type: T.Type , changed: @escaping (() -> ())) throws

}
