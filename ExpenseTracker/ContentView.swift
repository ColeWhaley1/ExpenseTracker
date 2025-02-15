//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/14/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var dayExpenses: [DayExpenses]
    
    private var indexToStringDays: [String] = ["S", "M", "T", "W", "TH", "F", "S"]

    var body: some View {
        HStack{
            ForEach(dayExpenses){ dayExpense in
                VStack{
                    Text(indexToStringDays[dayExpense.day])
                    
                }
            }
        }
        .onAppear{
            initializeDays()
        }
    }
    
    private func initializeDays(){
        if(dayExpenses.isEmpty){
            let initDays = [
                DayExpenses(day: 0, expenses: []),
                DayExpenses(day: 1, expenses: []),
                DayExpenses(day: 2, expenses: []),
                DayExpenses(day: 3, expenses: []),
                DayExpenses(day: 4, expenses: []),
                DayExpenses(day: 5, expenses: []),
                DayExpenses(day: 6, expenses: []),
            ]
            for day in initDays{
                modelContext.insert(day)
            }
        }
    }

}



#Preview {
    ContentView()
        .modelContainer(for: DayExpenses.self, inMemory: true)
}
