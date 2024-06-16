//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daehoon Lee on 6/16/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingScore = false
    @State private var isShowingGameOver = false
    
    @State private var shouldWin = Bool.random()
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var computerPick = Int.random(in: 0...2)
    @State private var playerPick = -1
    
    @State private var currentRound = 1
    
    private let totalRound = 10
    private let choices = ["rock", "paper", "scissor"]
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                Color(red: 0.4, green: 0.1, blue: 0.4),
                Color(red: 0.7, green: 0.252, blue: 0.25)
            ], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Rock Paper Scissor")
                    .font(.largeTitle.bold())
                    .foregroundStyle(LinearGradient(colors: [
                        Color(red: 0.7, green: 0.9, blue: 0.5),
                        Color(red: 0.525, green: 0.525, blue: 0.35),
                        Color(red: 0.255, green: 0.443, blue: 0.25)
                    ], startPoint: .top, endPoint: .bottom))
                    .padding(.bottom)
                
                ChoiceImage(of: choices[computerPick], 256)
                
                HStack(spacing: 0) {
                    Text("How to ")
                    Text(shouldWin ? "win" : "lose")
                        .foregroundStyle(shouldWin ? .green : .red)
                    Text(" this round?")
                }
                .font(.title2.bold())
                .padding()
                
                HStack(spacing: 35) {
                    ForEach(0..<3) { index in
                        Button {
                            choiceTapped(index)
                        } label: {
                            ChoiceImage(of: choices[index], 64)
                                .padding(10)
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                Text("Round: \(currentRound)/\(totalRound)")
                    .font(.title.bold())
                
                Text("Score: \(score)")
                    .font(.title2)
                    .padding(.top, -10)
                
                Spacer()
            }
        }
        .alert(scoreTitle, isPresented: $isShowingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            if scoreTitle == "Draw" {
                Text("Nobody wins this round!")
            } else if scoreTitle == "Correct" {
                Text("You got the correct answer!\nYour score is \(score)")
            } else {
                Text("You got the wrong answer!\nYour score is \(score)")
            }
        }
        .alert("Game Over!", isPresented: $isShowingGameOver) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Your final score is \(score) out of \(totalRound).")
        }
    }
    
    func moveResult(_ player: Int) -> String {
        if playerPick == computerPick { return "Draw" }
        
        let winningMoves = [1, 2, 0]
        let didWin: Bool
        
        if shouldWin {
            didWin = playerPick == winningMoves[computerPick]
        } else {
            didWin = computerPick == winningMoves[playerPick]
        }
        
        return didWin ? "Correct" : "Wrong"
    }
    
    func choiceTapped(_ number: Int) {
        playerPick = number
        
        scoreTitle = moveResult(playerPick)
        score = scoreTitle == "Draw" ? score : scoreTitle == "Correct" ? score + 1 : score - 1
        
        score = score < 0 ? 0 : score
        
        isShowingScore = true
    }
    
    func askQuestion() {
        if currentRound == totalRound {
            isShowingGameOver = true
        } else {
            currentRound += 1
            shouldWin.toggle()
            computerPick = Int.random(in: 0...2)
        }
    }
    
    func restartGame() {
        shouldWin = Bool.random()
        computerPick = Int.random(in: 0...2)
        score = 0
        currentRound = 1
    }
}

#Preview {
    ContentView()
}
