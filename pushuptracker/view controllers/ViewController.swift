//
//  ViewController.swift
//  pushuptracker
//
//  Created by Jared Alexander on 10/29/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushupRecordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func findGymsButtonPressed(_ sender: Any) {
        
        print("find gyms pressed")
        performSegue(withIdentifier: "gymsSegue", sender: self)
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        
        let shareText = "Check out my pushup record: \(PersistenceManager.sharedInstance.fetchPushupRecord())!!!"
        
        let activityViewController = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pushupRecordLabel.text = "Pushup Record: \(PersistenceManager.sharedInstance.fetchPushupRecord())"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
}

