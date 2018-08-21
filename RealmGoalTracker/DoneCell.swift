//
//  DoneCell.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/21/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import UIKit

class DoneCell: UITableViewCell {
    
    @IBOutlet weak var doneLabel: UILabel!
    
    func configure(with myDoneTask: RealmTask) {
        doneLabel.text = myDoneTask.task
    }
    
   
    
    
}
