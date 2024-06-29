//
//  ContentView.swift
//  iExpense
//
//  Created by Daehoon Lee on 6/27/24.
//

import SwiftUI

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            List {
                ExpenseSectionView(title: "Business", expenses: expenses.businessItems, deleteItems: removeItems)
                
                ExpenseSectionView(title: "Personal", expenses: expenses.personalItems, deleteItems: removeItems)
            }
            .navigationTitle("iExpense 💸")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        VStack {
                            Image(systemName: "cart")
                                .font(.system(size: 128))
                            
                            Text("Your Expenses is Empty!")
                                .font(.system(size: 22, weight: .heavy, design: .rounded))
                                .padding()
                        }
                    }, description: {
                        Text("Tap the button to add items")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                    }, actions: {
                        Button("Add Expenses") {
                            showingAddExpense = true
                        }
                        .font(.headline)
                        .buttonStyle(.borderedProminent)
                    })
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
