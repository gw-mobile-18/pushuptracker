//
//  Workout.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/12/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import Foundation

class Workout: Codable {
    let name: String
    let date: Date
    let pushupsCompleted:Int
    
    init(name: String, date: Date, pushupsCompleted: Int) {
        self.name = name
        self.date = date
        self.pushupsCompleted = pushupsCompleted
    }
}
