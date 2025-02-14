//
//  Item.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/14/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
