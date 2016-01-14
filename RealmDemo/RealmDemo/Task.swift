//
//  Task.swift
//  RealmDemo
//
//  Created by mengxiangjian on 15/12/22.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    
    dynamic var name = ""
    dynamic var createAt = NSDate()
    dynamic var notes = ""
    dynamic var isCompleted = false
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
