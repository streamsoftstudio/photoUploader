//
//  Collections.swift
//  Sony 360 RA
//
//  Created by Andrija Milovanovic on 6/28/21.
//

import Foundation

extension Dictionary {
    
    var toStringDictionary:[String:String] {
        return Dictionary<String,String>(uniqueKeysWithValues: self.compactMap{("\($0.key)","\($0.value)")})
    }
}


extension Array {
    public subscript(safeIndex index: Int?) -> Element? {
        guard let index = index, index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
extension Array where Element: Hashable {
    var uniques: Array {
        var buffer = Array()
        var added = Set<Element>()
        for elem in self {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
    
}
extension Array where Element: Hashable {
    
    func next(item: Element?, round:Bool) -> Element? {
        guard let item = item else {
            return nil
        }
        if let index = self.firstIndex(of: item), index + 1 <= self.count {
            return index + 1 == self.count ? (round ? self[0] : nil) : self[index + 1]
        }
        return nil
    }
    
    func prev(item: Element?, round:Bool) -> Element? {
        guard let item = item else {
            return nil
        }
        if let index = self.firstIndex(of: item), index >= 0 {
            return index == 0 ? (round ? self.last : nil) : self[index - 1]
        }
        return nil
    }
}
public extension NSDictionary {
    
    var swiftDictionary:Dictionary<String,Any> {
    
        var dict = Dictionary<String,Any>()
        for key: Any in self.allKeys {
            let stringKey = key as! String
            if let keyValue = self.value(forKey: stringKey) {
                dict[stringKey] = keyValue
            }
        }
        return dict
    }
}

extension Sequence {
    func group<GroupingType: Hashable>(by key: (Iterator.Element) -> GroupingType) -> [[Iterator.Element]] {
        var groups: [GroupingType: [Iterator.Element]] = [:]
        var groupsOrder: [GroupingType] = []
        forEach { element in
            let key = key(element)
            if case nil = groups[key]?.append(element) {
                groups[key] = [element]
                groupsOrder.append(key)
            }
        }
        return groupsOrder.map { groups[$0]! }
    }
}

