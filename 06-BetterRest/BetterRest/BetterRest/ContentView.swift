//
//  ContentView.swift
//  BetterRest
//
//  Created by Daehoon Lee on 6/17/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        let components = DateComponents(hour: 7, minute: 0)
        return Calendar.current.date(from: components) ?? .now
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Icon(icon: "clock")
                        DatePicker("Enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    }
                } header: {
                    Text("When do you want to wake up")
                        .headerStyle()
                }

                Section {
                    HStack {
                        Icon(icon: "bed.double")
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                } header: {
                    Text("Desired amount of sleep")
                        .headerStyle()
                }

                Section {
                    HStack {
                        Icon(icon: "cup.and.saucer")
                        Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                            ForEach(1...20, id: \.self) {
                                Text("^[\($0) cup](inflect: true)")
                            }
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                        .headerStyle()
                }
                
                Section {
                    VStack {
                        Text("Recommended bedtime")
                            .foregroundStyle(.pink)
                        Text(calculateBedtime())
                            .font(.title2.bold())
                            .padding()
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("BetterRest 🌙")
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct Icon: View {
    let icon: String
    
    var body: some View {
        Image(systemName: icon)
            .foregroundStyle(.blue)
    }
}

struct HeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline.bold())
            .foregroundStyle(.pink)
    }
}

extension View {
    func headerStyle() -> some View {
        modifier(HeaderStyle())
    }
}

#Preview {
    ContentView().preferredColorScheme(.dark)
}
