//
//  JournalViewController.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/23/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import Foundation
import RealmSwift

class JournalViewController: UIViewController {
    
    
    
    @IBAction func onTapCancel(_ sender: Any) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTapSave(_ sender: Any) {
        
    }
    
}
