//
//  PersistenceManager.swift
//  pushuptracker
//
//  Created by Jared Alexander on 11/12/18.
//  Copyright © 2018 Jared Alexander. All rights reserved.
//

import Foundation

class PersistenceManager {
    static let sharedInstance = PersistenceManager()
    
    let workoutsKey = "workouts"
    
    func saveWorkout(workout: Workout) {
        let userDefaults = UserDefaults.standard
        
        var workouts = fetchWorkouts()
        workouts.append(workout)
        
        let encoder = JSONEncoder()
        let encodedWorkouts = try? encoder.encode(workouts)
    
        userDefaults.set(encodedWorkouts, forKey: workoutsKey)
    }
    
    func fetchWorkouts() -> [Workout] {
        let userDefaults = UserDefaults.standard
    
        if let workoutData = userDefaults.data(forKey: workoutsKey), let workouts = try? JSONDecoder().decode([Workout].self, from: workoutData) {
            //workoutData is non-nil and successfully decoded
            return workouts
        }
        else {
            return [Workout]()
        }
    }
    
    func fetchPushupRecord() -> Int {
        let workouts = fetchWorkouts()
        
        return workouts.sorted(by: {$0.pushupsCompleted > $1.pushupsCompleted}).first?.pushupsCompleted ?? 0
    }
}
