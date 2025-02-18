//
//  BudgetComponent.swift
//  ExpenseTracker
//
//  Created by Cole Whaley on 2/17/25.
//

import SwiftUI

struct BudgetComponent: View {
    
    @Binding var budget: String
    
    var body: some View {
        HStack{
            Text("Weekly Budget")
            Image(systemName: "arrow.right")
                .foregroundColor(.orange)
            
            HStack {
                Text("$")
                TextField("", text: $budget)
                    .multilineTextAlignment(.center)
                    .padding(.trailing, 12)
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
    }
}
