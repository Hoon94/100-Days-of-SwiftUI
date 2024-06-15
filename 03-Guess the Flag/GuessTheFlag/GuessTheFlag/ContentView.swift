//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daehoon Lee on 6/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var currentScore = 0
    @State private var currentRound = 1
    
    let numberOfRounds = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                        } label: {
                            FlagImage(country: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Round: \(currentRound)")
                    .foregroundStyle(.white)
                    .font(.title2)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("\(scoreMessage)\nYour score is \(currentScore)")
        }
        .alert("Game Over!", isPresented: $showingFinalScore) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(currentScore) out of \(numberOfRounds)")
        }

    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 1
            scoreMessage = "You got the correct answer!"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[number])"
        }
        
        guard currentRound < numberOfRounds else {
            showingFinalScore = true
            return
        }
        
        showingScore = true
        currentRound += 1
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        currentScore = 0
        currentRound = 1
    }
}

struct FlagImage: View {
    let country: String
    
    init(country: String) {
        self.country = country
    }
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
