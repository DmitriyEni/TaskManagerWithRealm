//
//  RealmTask.swift
//  24_TableRealm
//
//  Created by Dmitriy Eni on 28.04.2022.
//

import Foundation
import RealmSwift

class RealmTask: Object {
    @objc dynamic var id = 0
    @objc dynamic var taskName = ""
    
    convenience init(taskName: String = "") {
        self.init()
        self.taskName = taskName
        self.id = (RealmManager.read(type: RealmTask.self).map({$0.id}).max() ?? 0) + 1
    }
}


class RealmSubtask: Object {
    @objc dynamic var id = 0
    @objc dynamic var ownerID = 0
    @objc dynamic var subtaskName = ""
    @objc dynamic var isDone = false
    
    convenience init(ownerID: Int, subtaskName: String) {
        self.init()
        self.id = (RealmManager.read(type: RealmSubtask.self).map({$0.id}).max() ?? 0) + 1
        self.ownerID = ownerID
        self.subtaskName = subtaskName
        self.isDone = false
    }
}
