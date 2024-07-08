//
//  ContentView.swift
//  HabitTracking
//
//  Created by Daehoon Lee on 7/8/24.
//

import SwiftUI

struct ContentView: View {
    @State private var habitStore = HabitStore()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(habitStore.allHabits) { habit in
                    NavigationLink(destination: HabitDetailView(habitStore: $habitStore, habit: habit)) {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                            
                            Text(habit.description)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    removeItems(atOffsets: indexSet)
                })
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("New Habit", systemImage: "plus") {
                        showingSheet.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingSheet, content: {
                NewHabit(habitStore: $habitStore.allHabits)
            })
        }
    }
    
    func removeItems(atOffsets: IndexSet) {
        habitStore.allHabits.remove(atOffsets: atOffsets)
    }
}

#Preview {
    ContentView()
}
