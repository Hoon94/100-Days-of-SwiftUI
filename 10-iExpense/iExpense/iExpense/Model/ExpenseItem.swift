//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Daehoon Lee on 6/29/24.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
