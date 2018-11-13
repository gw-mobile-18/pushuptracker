//
//  PushupTrackerViewController.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/5/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import UIKit

class PushupTrackerViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var countLabel: UILabel!
    
    private var count = 0 {
        didSet {
            countLabel.text = String(count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
    
        // Do any additional setup after loading the view.
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        let name = nameTextField.text ?? "???"
        print("\(name) did \(count) pushup(s)")
        
        let workout = Workout(name: name, date: Date(), pushupsCompleted: count)
        PersistenceManager.sharedInstance.saveWorkout(workout: workout)
        
        count = 0
    }
    
    @IBAction func noseButtonPressed(_ sender: Any) {
        count += 1
    }
}

extension PushupTrackerViewController: UITextFieldDelegate {
    
    //hide keyboard on pressing return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        
        return true
    }
    
    //don't allow numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let decimalCharacters = CharacterSet.decimalDigits
        
        let decimalRange = string.rangeOfCharacter(from: decimalCharacters)
        
        if decimalRange != nil {
            return false
        }
        
        return true
    }
}
