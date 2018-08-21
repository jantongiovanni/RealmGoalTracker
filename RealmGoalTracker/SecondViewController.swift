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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let secondRealm = RealmService.shared.realm
        myDoneTasks = secondRealm.objects(RealmTask.self)
        
        secondNotificationToken = secondRealm.observe { (notification, realm) in
            self.tableView.reloadData()
            //returns notification token
        }
        
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            print(error ?? "no error detected")
        }    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        secondNotificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }


}

extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDoneTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "doneGoalCell") as? DoneCell else { return UITableViewCell() }
        let myDoneTask = myDoneTasks[indexPath.row]
        cell.configure(with: myDoneTask)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        print("delete")
        let myDoneTask = myDoneTasks[indexPath.row]
        RealmService.shared.delete(myDoneTask)
    }
}

