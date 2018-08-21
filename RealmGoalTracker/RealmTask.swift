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
    
    dynamic var task: String = ""
    let isComplete = RealmOptional<Bool>()
    
    convenience init(task: String, isComplete: Bool?){
        self.init()
        self.task = task
        self.isComplete.value = isComplete
    }
    
}
