//
//  Task.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 7/8/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit
import RealmSwift

class Task: Object {
    dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}
