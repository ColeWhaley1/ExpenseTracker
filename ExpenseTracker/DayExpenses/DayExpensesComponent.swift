
import SwiftUI

struct DayExpensesComponent: View {
    
    let day: Int
    @State var expenses: [Expense]
    
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
                            TextField("what", text: $expenseTitle)
                                .onSubmit{
                                    addExpense()
                                }
                            TextField("$", text: $expenseCost)
                                .frame(maxWidth: 50, alignment: .trailing)
                                .multilineTextAlignment(.trailing)
                                .onSubmit{
                                    addExpense()
                                }
                        }
                        .padding(10)
                    }
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                 
                    Button(action: toggleInitiateNewExpense){
                        Image(systemName: "multiply")
                    }
                }
            }
            
            VStack(spacing: 10){
                ForEach(expenses){ expense in
                    HStack{
                        Text(expense.title)
                        Spacer()
                        Text("$\(expense.cost.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", expense.cost) : String(format: "%.2f", expense.cost))")
                    }
                }
            }
            .padding(.vertical, (expenses.isEmpty) ? 10 : 20)

        }
    }
    
    private func addExpense(){
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
    
    private func toggleInitiateNewExpense() {
        newExpenseInitiated = !newExpenseInitiated
    }
}

