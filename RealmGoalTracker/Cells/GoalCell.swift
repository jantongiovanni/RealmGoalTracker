//
//  GoalCell.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/20/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    @IBOutlet weak var goalLabel: UILabel!
    
    func configure(with myTask: RealmTask) {
        goalLabel.text = myTask.task
    }

}
