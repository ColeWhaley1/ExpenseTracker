
import SwiftUI

struct DayExpensesComponent: View {
    
    let day: Int
    @Binding var expenses: [Expense]
    
    var sumCosts: Double {
        expenses.reduce(0, { total, expense in
            total + expense.cost
        })
    }
    
    var sortedExpenses: [Expense] {
        expenses.sorted { $0.cost > $1.cost }
    }
    
    @Environment(\.modelContext) private var modelContext
    
    private let dayLabel: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    @State private var newExpenseInitiated: Bool = false
    @State private var expenseTitle: String = ""
    @State private var expenseCost: String = ""
    
    var body: some View {
        VStack{
            HStack {
                Text(dayLabel[day])
                    .fontWeight(.bold)
                    .frame(minWidth: 50)
                    .padding(10)
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(Color.white)
                
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.green)
                
                Text("$ \(sumCosts.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", sumCosts) : String(format: "%.2f", sumCosts))")
                    .fontWeight(.bold)
                    .font(.title3)
                
                Spacer()
                
                Button(action: newExpenseInitiated ? addExpense : toggleInitiateNewExpense){
                    if(newExpenseInitiated){
                        Text("Confirm")
                    } else {
                        Image(systemName: "plus")
                    }
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if(newExpenseInitiated){
                HStack {
                    HStack{
                        HStack {
                            TextField("expense", text: $expenseTitle)
                                .padding()
                                .onSubmit{
                                    addExpense()
                                }
                                .frame(maxWidth: 200)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            TextField("$", text: $expenseCost)
                                .padding()
                                .frame(maxWidth: 100, alignment: .leading)
                                .multilineTextAlignment(.leading)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .onSubmit{
                                    addExpense()
                                }
                        }
                        .padding(10)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                 
                    Button(action: toggleInitiateNewExpense){
                        Image(systemName: "multiply")
                    }
                }
            }
            
            VStack(spacing: 10){
                ForEach(sortedExpenses, id: \.id){ expense in
                    HStack{
                        Spacer().frame(maxWidth: 10)
                        Text(expense.title)
                        Spacer()
                        Text("$ \(expense.cost.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", expense.cost) : String(format: "%.2f", expense.cost))")
                            .fontWeight(.semibold)
                        Spacer().frame(maxWidth: 20)
                        Button(role: .destructive, action: {deleteExpense(expense: expense)}){
                            Image(systemName: "trash")
                        }
                    }
                    Divider()
                }
            }
            .padding(.vertical, (expenses.isEmpty) ? 10 : 20)

        }
    }
    
    private func addExpense() {
        guard !expenseTitle.isEmpty else { return }
        guard !expenseCost.isEmpty else { return }
        
        guard let cost = Double(expenseCost) else { return }
        
        let expense = Expense(title: expenseTitle, cost: cost)
        expenses.append(expense)
        modelContext.insert(expense)
        
        expenseTitle = ""
        expenseCost = ""
        newExpenseInitiated = false
    }
    
    private func deleteExpense(expense: Expense) {
        modelContext.delete(expense)
        expenses.removeAll {
            $0.id == expense.id
        }
    }
    
    private func toggleInitiateNewExpense() {
        newExpenseInitiated = !newExpenseInitiated
    }
}

