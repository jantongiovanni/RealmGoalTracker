//
//  RealmTask.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/20/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class RealmTask: Object {
    
    dynamic var createdAt = Date()
    dynamic var task: String = ""
    dynamic var isComplete = false
    
    convenience init(createdAt: Date, task: String, isComplete: Bool){
        self.init()
        self.createdAt = createdAt
        self.task = task
        self.isComplete = isComplete
    }
    
}
