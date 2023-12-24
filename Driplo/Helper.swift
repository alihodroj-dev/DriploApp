//
//  Helper.swift
//  Driplo
//
//  Created by Ali Hodroj on 19/12/2023.
//

import Foundation
import UserNotifications

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
    
    func askForPermissions() {
        // asking for permissions
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func initializeNotification() {
        // creating notification content
        let content = UNMutableNotificationContent()
        content.title = "Driplo: Reminder"
        content.subtitle = "It's time to drink!"
        content.sound = .default
        
        //creating the trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3*60*60, repeats: true)
        
        // creating request
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // adding request to UNCenter
        let UNCenter = UNUserNotificationCenter.current()
        UNCenter.add(request) { err in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                print("added")
            }
        }
    }
}
