//
//  FirstViewController.swift
//  RealmGoalTracker
//
//  Created by JoesMac on 8/17/18.
//  Copyright © 2018 JoeA. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell") as? GoalCell else { return UITableViewCell() }
        //let pickUpLine = pickUpLines[indexPath.row]
        //cell.configure(with: pickUpLine)
       return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
}

extension FirstViewController: UITableViewDelegate {
}
