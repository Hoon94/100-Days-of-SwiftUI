//
//  ContentView.swift
//  UnitConverter
//
//  Created by Daehoon Lee on 6/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue: Double = 0
    @State private var inputUnit: Dimension = UnitDuration.hours
    @State private var outputUnit: Dimension = UnitDuration.seconds
    @State private var selectedUnits = 2
    @FocusState private var inputIsFocused: Bool
    
    let conversionTypes = ["Temperature", "Length", "Time", "Volume"]
    
    var units: [[Dimension]] {
        let temperatureUnits: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
        let lengthUnits: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
        let timeUnits: [UnitDuration] = [.seconds, .minutes, .hours]
        let volumeUnits: [UnitVolume] = [.milliliters, .liters, .cups, .pints, .gallons]
        
        return [temperatureUnits, lengthUnits, timeUnits, volumeUnits]
    }
    
    let formatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
        
        return formatter
    }()
    
    var result: String {
        let outputMeasurement = Measurement(value: inputValue, unit: inputUnit).converted(to: outputUnit)
        
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Amount to Convert") {
                    TextField("Input", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }
                
                Section("\(formatter.string(from: inputUnit)) to \(formatter.string(from: outputUnit))") {
                    Picker("Convert from Unit", selection: $inputUnit) {
                        ForEach(units[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Convert to Unit", selection: $outputUnit) {
                        ForEach(units[selectedUnits], id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Result") {
                    Text(result)
                }
                
                Picker("Conversion", selection: $selectedUnits) {
                    ForEach(0..<conversionTypes.count, id: \.self) {
                        Text(conversionTypes[$0])
                    }
                }
                .pickerStyle(.wheel)
                .frame(maxHeight: 170)
            }
            .navigationTitle("Convertia")
            .toolbar {
                if inputIsFocused {
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
            .onChange(of: selectedUnits) {
                inputUnit = units[selectedUnits][0]
                outputUnit = units[selectedUnits][1]
            }
        }
    }
}

#Preview {
    ContentView()
}
