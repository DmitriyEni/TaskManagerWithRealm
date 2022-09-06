//
//  RealmManager.swift
//  24_TableRealm
//
//  Created by Dmitriy Eni on 28.04.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    private static let realm = try! Realm()
    
    class func startTransaction() {
        realm.beginWrite()
    }
    
    class func closeTransaction() {
        try? realm.commitWrite()
    }
    
    class func read<T: Object>(type: T.Type) -> [T] {
        return Array(realm.objects(type.self))
    }
    
    class func write<T: Object>(object: T) {
        try? realm.write({
            realm.add(object)
        })
    }
    
    class func delete<T: Object>(object: T) {
        try? realm.write({
            realm.delete(object)
        })
    }
}

