//
//  Helper.swift
//  Driplo
//
//  Created by Ali Hodroj on 19/12/2023.
//

import Foundation

class Helper {
    
    static var HELPER: Helper = Helper()
    
    func initializeDate(_ givenWeight: Int, _ unit: WeightUnit) {
        
        switch unit {
            
        case .KG:
            let dailyGoal = 35 * givenWeight
            UserDefaults.standard.set(dailyGoal, forKey: "DAILY_GOAL")
            UserDefaults.standard.set("mL", forKey: "UNIT")
            UserDefaults.standard.set(0, forKey: "LEFT_TO_DRINK")
            let components = Calendar.current.dateComponents([.day], from: Date.now)
            UserDefaults.standard.setValue(Calendar.current.date(from: components), forKey: "LAST_UPDATED")
        case .LB:
            let dailyGoal = Int(0.75 * Double(givenWeight))
            UserDefaults.standard.set(dailyGoal, forKey: "DAILY_GOAL")
            UserDefaults.standard.set("Oz", forKey: "UNIT")
            UserDefaults.standard.set(0, forKey: "LEFT_TO_DRINK")
            let components = Calendar.current.dateComponents([.day], from: Date.now)
            UserDefaults.standard.setValue(Calendar.current.date(from: components), forKey: "LAST_UPDATED")
        }
    }
}
