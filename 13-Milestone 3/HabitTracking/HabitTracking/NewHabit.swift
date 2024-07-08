//
//  NewHabit.swift
//  HabitTracking
//
//  Created by Daehoon Lee on 7/8/24.
//

import SwiftUI

struct NewHabit: View {
    @Binding var habitStore: [Habit]
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationTitle("New Habit")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newHabit = Habit(name: name, description: description, count: 0)
                        habitStore.append(newHabit)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewHabit(habitStore: .constant([Habit(name: "Test", description: "This is for the test.", count: 0)]))
}
