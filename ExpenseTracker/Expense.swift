//
//  Expense.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/15/25.
//

import Foundation
import SwiftData

@Model
final class Expense {
    
    var title: String
    var cost: Float
    
    init(title: String, cost: Float){
        self.title = title
        self.cost = cost
    }
    
}
