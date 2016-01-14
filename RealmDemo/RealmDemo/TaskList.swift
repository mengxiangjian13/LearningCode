//
//  TaskList.swift
//  RealmDemo
//
//  Created by mengxiangjian on 15/12/24.
//  Copyright © 2015年 mengxiangjian. All rights reserved.
//

import Foundation
import RealmSwift

class TaskList: Object {
    
    dynamic var name = ""
    dynamic var createAt = NSDate()
    let tasks = List<Task>()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
