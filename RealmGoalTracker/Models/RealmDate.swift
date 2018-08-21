//
//  RealmDate.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/21/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class RealmDate: Object {
    
    dynamic var createdAt = Date()
    dynamic var note: String? = nil
    let mood = RealmOptional<Int>()
    let tasks = List<RealmTask>()

}
