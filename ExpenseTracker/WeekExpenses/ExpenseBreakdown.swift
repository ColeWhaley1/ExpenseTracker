//
//  ExpenseBreakdown.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/17/25.
//

import SwiftUI
import Charts

struct ExpenseBreakdown: View {
    @Binding var weekExpenses: [DayExpenses]
    
    private let dayLabel: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var dailyTotals: [DayExpenseTotal] {
        weekExpenses.map { dayExpense in
            let totalCost: Double = dayExpense.expenses.reduce(0) { $0 + $1.cost }
            return DayExpenseTotal(day: dayExpense.day, total: totalCost)
        }
    }
    
    var maxTotalDay: DayExpenseTotal? {
        dailyTotals.max{ $0.total < $1.total }
    }
    
    var body: some View {
        Chart(dailyTotals){ data in
            LineMark(
                x: .value("Day", dayLabel[data.day]),
                y: .value("Total", data.total)
            )
            .foregroundStyle(.green)
            .interpolationMethod(.monotone)
        }
        .padding(20)
        .chartXScale(domain: dayLabel)
        .chartYScale(domain: 0...((maxTotalDay?.total ?? 0) + 300))
        .frame(minHeight: 150)
    }
    
}
