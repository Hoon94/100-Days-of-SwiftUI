//
//  ExpenseSectionView.swift
//  iExpense
//
//  Created by Daehoon Lee on 6/29/24.
//

import SwiftUI

struct ExpenseSectionView: View {
    let title: String
    let expenses: [ExpenseItem]
    let deleteItems: (IndexSet) -> Void
    
    var body: some View {
        Section {
            ForEach(expenses) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundStyle(item.amount <= 10 ? .green : item.amount <= 100 ? .yellow : .red)
                }
            }
            .onDelete(perform: deleteItems)
        } header: {
            if expenses.count != 0 {
                HeaderView(headerTitle: title)
            }
        }
    }
}

#Preview {
    ExpenseSectionView(title: "Business", expenses: [ExpenseItem(name: "MacBook", type: "Business", amount: 1_500_000)], deleteItems: { _ in })
}
