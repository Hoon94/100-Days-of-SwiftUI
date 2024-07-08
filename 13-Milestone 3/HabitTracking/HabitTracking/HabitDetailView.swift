//
//  HabitDetailView.swift
//  HabitTracking
//
//  Created by Daehoon Lee on 7/8/24.
//

import SwiftUI

struct HabitDetailView: View {
    @Binding var habitStore: HabitStore
    var habit: Habit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(habit.description)
                .font(.body)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 20) {
                Text("Count:")
                
                Text("\(habit.count)")
                    .foregroundStyle(.blue)
            }
            .font(.headline)
            
            Button {
                var copy = habit
                copy.count += 1
                guard let index = habitStore.allHabits.firstIndex(of: habit) else { return }
                habitStore.allHabits[index] = copy
            } label: {
                Text("Increase Count")
                    .font(.headline)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle(habit.name)
    }
}

#Preview {
    NavigationStack {
        HabitDetailView(habitStore: .constant(HabitStore()), habit: Habit(name: "Test", description: "This is for the preview.", count: 0))
    }
}
