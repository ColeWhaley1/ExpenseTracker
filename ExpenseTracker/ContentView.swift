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
    @Query(sort: \DayExpenses.day) private var dayExpensesFetch: [DayExpenses]
    @State private var dayExpenses: [DayExpenses] = []
    
    var weeklyCost: Double {
        let dailyTotals = dayExpenses.map { dayExpenseList in
            dayExpenseList.expenses.reduce(0) { total, expense in
                total + expense.cost
            }
        }
        return dailyTotals.reduce(0, +)
    }

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
                    Text("Week Total")
                        .padding(.leading, 20)
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                        .foregroundColor(Color.green)
                    Text("$ \(weeklyCost.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", weeklyCost) : String(format: "%.2f", weeklyCost))")
                        .fontWeight(.bold)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                
                
                HStack{
                    VStack{
                        ForEach(dayExpenses.indices, id: \.self) { index in
                            HStack {
                                DayExpensesComponent(day: dayExpenses[index].day, expenses: $dayExpenses[index].expenses)
                            }
                        }
                    }
                    .onAppear{
                        initializeDays()
                        dayExpenses = dayExpensesFetch
                    }
                    .onChange(of: dayExpensesFetch) {
                        dayExpenses = dayExpensesFetch
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
            let initDays: [DayExpenses] = [
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

