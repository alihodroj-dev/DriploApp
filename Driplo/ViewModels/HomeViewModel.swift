//
//  HomeViewModel.swift
//  Driplo
//
//  Created by Ali Hodroj on 18/12/2023.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var progress: CGFloat
    @Published var unit: String
    @Published var leftToDrink: Int {
        didSet {
            self.progress = CGFloat(Double(self.leftToDrink) / Double(self.dailyGoal))
        }
    }
    @Published var dailyGoal: Int
    @Published var lastUpdated: Date
    @Published var selectedCup: String = "100"
    
    init() {
        let UD = UserDefaults.standard
        self.unit = UD.string(forKey: "UNIT") ?? "unit"
        self.leftToDrink = UD.integer(forKey: "LEFT_TO_DRINK")
        self.dailyGoal = UD.integer(forKey: "DAILY_GOAL")
        self.lastUpdated = UD.object(forKey: "LAST_UPDATED") as! Date
        self.progress = 0
    }
    
    func Drink(_ amount: Int) {
        var value = UserDefaults.standard.integer(forKey: "LEFT_TO_DRINK")
        value += amount
        UserDefaults.standard.set(value, forKey: "LEFT_TO_DRINK")
        withAnimation(.bouncy) {
            self.leftToDrink = value
        }
    }
    
}
