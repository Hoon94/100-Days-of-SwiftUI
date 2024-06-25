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
    
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var scaleAmount = 1.0
    
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
                        .rotation3DEffect(Angle(degrees: correctAnswer == number ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(correctAnswer == number ? 1 : opacityAmount)
                        .scaleEffect(correctAnswer == number ? 1 : scaleAmount)
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
        withAnimation {
            animationAmount += 360
            opacityAmount = 0.25
            scaleAmount = 0.85
        }
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentRound += 1
        
        animationAmount = 0
        opacityAmount = 1.0
        scaleAmount = 1.0
    }
    
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        currentScore = 0
        currentRound = 1
        
        animationAmount = 0
        opacityAmount = 1.0
        scaleAmount = 1.0
    }
}

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

#Preview {
    ContentView()
}
