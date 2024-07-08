//
//  Habit.swift
//  HabitTracking
//
//  Created by Daehoon Lee on 7/8/24.
//

import Foundation

struct Habit: Codable, Equatable, Identifiable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int
}

@Observable
class HabitStore {
    var allHabits: [Habit] {
        didSet {
            if let encodedItem = try? JSONEncoder().encode(allHabits) {
                UserDefaults.standard.set(encodedItem, forKey: "Habits")
            }
        }
    }
    
    init() {
        guard let savedItems = UserDefaults.standard.data(forKey: "Habits"),
              let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) 
        else {
            allHabits = []
            return
        }
        
        allHabits = decodedItems
    }
}
