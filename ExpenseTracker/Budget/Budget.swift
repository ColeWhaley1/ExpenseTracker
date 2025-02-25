//
//  Budget.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/18/25.
//

import SwiftData

@Model
final class Budget {
    var amount: Double
    
    init(amount: Double){
        self.amount = amount
    }
}
