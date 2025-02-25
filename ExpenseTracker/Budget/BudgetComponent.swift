//
//  BudgetComponent.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/17/25.
//

import SwiftUI
import SwiftData

struct BudgetComponent: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query var budgetFetch: [Budget]
    @Binding var budgetAmount: String
    
    var body: some View {
        HStack{
            Text("Weekly Budget")
            Image(systemName: "arrow.right")
                .foregroundColor(.orange)
            
            HStack {
                Text("$")
                TextField("", text: $budgetAmount)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 12)
                    .onChange(of: budgetAmount) {
                        updateBudget(newBudget: budgetAmount)
                    }
            }
            .keyboardType(.decimalPad)
            .foregroundColor(.orange)
            .padding(8)
            .frame(width: 130)
            .background(Color(.orange.opacity(0.1)))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
        }
        .fontWeight(.semibold)
        .font(.title2)
        .onAppear{
            loadBudget()
        }
    }
    
    private func loadBudget(){
        if let loadedBudget = budgetFetch.first {
            budgetAmount = String(loadedBudget.amount)
        } else {
            let newBudget = Budget(amount: 0)
            modelContext.insert(newBudget)
            budgetAmount = "0"
        }
    }
    
    private func updateBudget(newBudget: String){
        if let newBudgetDouble = Double(newBudget), let currBudget = budgetFetch.first {
            currBudget.amount = newBudgetDouble
            try? modelContext.save()
        }
    }
}
