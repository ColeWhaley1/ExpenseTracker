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
    @Query(sort: \DayExpenses.day) private var dayExpenses: [DayExpenses]

    var body: some View {
        
        ScrollView {
            VStack() {
                
                Text("Expense Tracker")
                    .fontWeight(.bold)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .foregroundColor(.green)
                
                
                HStack{
                    VStack{
                        ForEach(dayExpenses){ dayExpense in
                            HStack{
                                DayExpensesComponent(day: dayExpense.day, expenses: dayExpense.expenses)
                            }
                            .padding(5)
                        }
                    }
                    .onAppear{
                        initializeDays()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20.0)
                    .background(Color("WeekBackground"))
                    .cornerRadius(30.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.gray, lineWidth: 1)
                    )

                }
                .frame(maxWidth: UIScreen.main.bounds.width * 0.9)
                
            }
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

