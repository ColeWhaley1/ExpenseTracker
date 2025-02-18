//
//  DayExpenseTotal.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/17/25.
//

import SwiftData

@Model
final class DayExpenseTotal{
    var day: Int
    var total: Double
    
    init(day: Int, total: Double){
        self.day = day
        self.total = total
    }
}
