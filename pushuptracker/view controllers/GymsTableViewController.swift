//
//  GymsTableViewController.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/19/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import UIKit

class GymsTableViewController: UITableViewController {
    
    var gyms = [Gym]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let fourquareAPIManager = FourSquareAPIManager()
        fourquareAPIManager.delegate = self
        fourquareAPIManager.fetchGyms()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gyms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gymCell", for: indexPath) as! GymTableViewCell

        let gym = gyms[indexPath.row]
        
        cell.gymNameLabel.text = gym.name
        cell.gymAddressLabel.text = gym.address
        //TODO: set the image

        return cell
    }
}

extension GymsTableViewController: FetchGymsDelegate {
    func gymsFound(_ gyms: [Gym]) {
        print("gyms found - here they are in the controller!")
        self.gyms = gyms
    }
    
    func gymsNotFound() {
        print("no gyms found")
    }
}
