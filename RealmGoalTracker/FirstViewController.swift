//
//  FirstViewController.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/17/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import UIKit
import RealmSwift

class FirstViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taskTextField: UITextField!
    
    var myTasks: Results<RealmTask>!
    var firstNotificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Count: \(myTasks.count)")

        let firstRealm = RealmService.shared.realm
        myTasks = firstRealm.objects(RealmTask.self)
        
        firstNotificationToken = firstRealm.observe { (notification, realm) in
            self.tableView.reloadData()
            //returns notification token
        }
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "no error detected")
        }
    
        self.taskTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firstNotificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }

    @IBAction func onTapAddTask(_ sender: Any) {
        let taskText = taskTextField.text ?? ""
        let newTask = RealmTask(createdAt: Date(), task: taskText, isComplete: false)
        RealmService.shared.create(newTask)
    }
    
    
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let myTask = myTasks[indexPath.row]
        cell.configure(with: myTask)
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        print("delete")
        let myTask = myTasks[indexPath.row]
        RealmService.shared.delete(myTask)
    }
}
