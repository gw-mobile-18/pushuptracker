//
//  HistoryTableViewController.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/12/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    let workouts = PersistenceManager.sharedInstance.fetchWorkouts()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return workouts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = String(workouts[indexPath.row].pushupsCompleted)

        return cell
    }
}
