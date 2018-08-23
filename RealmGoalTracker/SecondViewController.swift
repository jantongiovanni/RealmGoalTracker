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
    
    var myDoneTasks: Results<RealmTask>!
    var secondNotificationToken: NotificationToken?
    
    var accessory = UITableViewCellAccessoryType.none

    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true

        tableView.allowsMultipleSelection = true
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        let secondRealm = RealmService.shared.realm
        myDoneTasks = secondRealm.objects(RealmTask.self)
        
        secondNotificationToken = secondRealm.observe { (notification, realm) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print("hit")
                //returns notification token
            }
            //returns notification token
        }
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "no error detected")
        }    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        secondNotificationToken?.invalidate()
//        RealmService.shared.stopObservingErrors(in: self)
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

