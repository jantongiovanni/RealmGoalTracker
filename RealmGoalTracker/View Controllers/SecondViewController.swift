//
//  SecondViewController.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/17/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var moodSlider: UISlider!
    
    var myDoneTasks: Results<RealmTask>!
    //var myDay: Results<RealmDate>!
    
    var secondNotificationToken: NotificationToken?
    var accessory = UITableViewCellAccessoryType.none

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true

        tableView.allowsMultipleSelection = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        //moodSlider.isContinuous = false
        
        let secondRealm = RealmService.shared.realm
        //myDay = secondRealm.objects(RealmDate.self)
        myDoneTasks = secondRealm.objects(RealmTask.self).sorted(byKeyPath: "createdAt", ascending: false)
        
        secondNotificationToken = secondRealm.observe { (notification, realm) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("reload table 1")
            }
        }
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "no error detected")
        }    }

    //come back to this when the model is more established
//    @IBAction func didMoveMoodSlider(_ sender: Any) {
//        let moodVal = moodSlider.value
//        print(moodVal)
//        let moodDict: [String: Any?] = ["mood" : moodVal]
//        RealmService.shared.update(myDay, with: moodDict)
//        print("done")
//    }
    
        
        
}




extension SecondViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDoneTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "doneGoalCell") as? DoneCell else { return UITableViewCell() }
        let myDoneTask = myDoneTasks[indexPath.row]
        if (myDoneTask.isComplete == true) {
           accessory = UITableViewCellAccessoryType.checkmark
            cell.accessoryType = accessory
        } else { cell.accessoryType = UITableViewCellAccessoryType.none}
        cell.configure(with: myDoneTask)
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        let selectedTask = myDoneTasks[indexPath.row]
        if (selectedTask.isComplete == false) {
            print("selected")
            let dict: [String: Any?] = ["isComplete" : true]
            RealmService.shared.update(selectedTask, with: dict) }
        else {
            print("deselected")
            let deselectedTask = myDoneTasks[indexPath.row]
            let dict: [String: Any?] = ["isComplete" : false]
            RealmService.shared.update(deselectedTask, with: dict)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        print("delete")
        let myDoneTask = myDoneTasks[indexPath.row]
        RealmService.shared.delete(myDoneTask)
    }
}

