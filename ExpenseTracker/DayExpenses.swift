//
//  Item.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/14/25.
//

import Foundation
import SwiftData

@Model
final class DayExpenses {
    var day: Int
    var expenses: [Expense]
    
    init(day: Int, expenses:[Expense] = []) {
        self.day = day
        self.expenses = expenses
    }
}
