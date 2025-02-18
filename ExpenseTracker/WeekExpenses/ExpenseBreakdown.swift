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
    @Binding var budget: String
    
    private let dayLabel: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var dailyTotals: [DayExpenseTotal] {
        weekExpenses.map { dayExpense in
            let totalCost: Double = dayExpense.expenses.reduce(0) { $0 + $1.cost }
            return DayExpenseTotal(day: dayExpense.day, total: totalCost)
        }
    }
    
    var maxTotalDay: DayExpenseTotal? {
        dailyTotals.max { $0.total < $1.total }
    }
    
    var budgetValue: Double {
        Double(budget) ?? 0
    }
    
    var body: some View {
        Chart {

            ForEach(dailyTotals, id: \.day) { data in
                LineMark(
                    x: .value("Day", dayLabel[data.day]),
                    y: .value("Total", data.total)
                )
                .foregroundStyle(.green)
                .interpolationMethod(.monotone)
            }
            if budgetValue > 0 {
                RuleMark(y: .value("Budget", budgetValue / 7))
                    .foregroundStyle(.orange)
                    .lineStyle(StrokeStyle(lineWidth: 2, dash: [5])) // Dotted line
                    .annotation(position: .top, alignment: .leading) {
                        Text("$\(Int(budgetValue / 7)) / day")
                            .font(.caption)
                            .foregroundColor(.orange)
                            .bold()
                }
                    .zIndex(-10)
            }
            
        }
        .padding(20)
        .chartXScale(domain: dayLabel)
        .chartYScale(domain: 0...max((maxTotalDay?.total ?? 0) + 300, budgetValue + 50))
        .frame(minHeight: 150)
    }
}
