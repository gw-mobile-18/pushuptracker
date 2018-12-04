//
//  GymsTableViewController.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/19/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import UIKit
import MBProgressHUD

class GymsTableViewController: UITableViewController {
    let foursquareAPIManager = FourSquareAPIManager()
    let locationDetector = LocationDetector()

    var gyms = [Gym]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        foursquareAPIManager.delegate = self
        locationDetector.delegate = self
        
        fetchGyms()
    }
    
    private func fetchGyms() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        locationDetector.findLocation()
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
        
        if let iconUrlString = gym.iconUrl, let url = URL(string: iconUrlString) {
            cell.gymLogoImage.load(url: url)
        }
        
        return cell
    }
}

extension GymsTableViewController: LocationDetectorDelegate {
    func locationDetected(latitude: Double, longitude: Double) {
        foursquareAPIManager.fetchGyms(latitude: latitude, longitude: longitude)
    }
    
    func locationNotDetected() {
        print("no location found :(")
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            //TODO: Show a AlertController with error
        }
    }
}

extension GymsTableViewController: FetchGymsDelegate {
    func gymsFound(_ gyms: [Gym]) {
        print("gyms found - here they are in the controller!")
        DispatchQueue.main.async {
            self.gyms = gyms

            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func gymsNotFound(reason: FourSquareAPIManager.FailureReason) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            
            let alertController = UIAlertController(title: "Problem fetching gyms", message: reason.rawValue, preferredStyle: .alert)
            
            switch(reason) {
            case .noResponse:
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
                    self.fetchGyms()
                })
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler:nil)
                
                alertController.addAction(cancelAction)
                alertController.addAction(retryAction)
                
            case .non200Response, .noData, .badData:
                let okayAction = UIAlertAction(title: "Okay", style: .default, handler:nil)
                
                alertController.addAction(okayAction)
            }
            
            self.present(alertController, animated: true, completion: nil)
        }

    }
}
