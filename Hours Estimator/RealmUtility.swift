//
//  RealmUtility.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 7/8/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit
import RealmSwift

final class RealmUtility: NSObject {
    
    static let sharedUtility = RealmUtility()
    
    func fetchAllTasks() -> [Task] {
        let realm = try! Realm()
        return realm.objects(Task).map{ $0 }
    }
    
    func save(task: Task) {
        let realm = try! Realm()
        try! realm.write({ 
            realm.add(task)
        })
    }
    
    func deleteTask(task: Task) {
        let realm = try! Realm()
        try! realm.write({ 
            realm.delete(task)
        })
    }
}
