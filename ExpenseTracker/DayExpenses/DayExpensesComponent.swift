
import SwiftUI

struct DayExpensesComponent: View {
    
    let day: Int
    let expenses: [Expense]
    
    private let dayLabel: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    @State private var newExpenseInitiated: Bool = false
    @State private var expenseTitle: String = ""
    @State private var expenseCost: String = ""
    
    var body: some View {
        VStack{
            HStack {
                Text(dayLabel[day])
                    .fontWeight(.bold)
                
                Spacer()
            
                Button(action: initiateNewExpense){
                    Text("+")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(expenses){ expense in
                HStack{
                    Text(expense.title)
                    Text("$")
                    Text(String(expense.cost))
                }
            }
            if(newExpenseInitiated){
                HStack{
                    HStack {
                        TextField("What", text: $expenseTitle)
                        Text("$")
                        TextField("cost", text: $expenseCost)
                            .frame(maxWidth: 50, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                    }
                    .padding(10)
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
        }
    }
    
    private func initiateNewExpense() {
        newExpenseInitiated = true
    }
}

