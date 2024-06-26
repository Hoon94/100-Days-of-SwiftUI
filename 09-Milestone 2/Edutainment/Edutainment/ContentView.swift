//
//  ContentView.swift
//  Edutainment
//
//  Created by Daehoon Lee on 6/26/24.
//

import SwiftUI

struct ContentView: View {
    @State private var game = Game()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.CustomBlue
                    .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    Spacer()
                    
                    Text("Multiplication Table")
                        .font(.title.bold())
                        .kerning(1)
                        .padding(.bottom, 30)
                    
                    HStack {
                        Text("Multiple of")
                            .frame(width: 130, height: 60)
                            .background(.CustomPink)
                        
                        Picker("Select multiplication table", selection: $game.multiplicationTable) {
                            ForEach(1..<13, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .accentColor(.black)
                        .frame(width: 60, height: 60)
                        .background(.CustomPurple)
                        .overlay(Rectangle()
                            .strokeBorder(.gray, lineWidth: 1)
                        )
                        
                    }
                    .background(.CustomPink)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.black, lineWidth: 1)
                    )
                    
                    HStack {
                        Text("Number of questions")
                            .frame(width: 130, height: 60)
                            .background(.CustomPink)
                        
                        Picker("Select difficulty", selection: $game.numberOfQuestions) {
                            ForEach(game.chooseQuestions, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .accentColor(.black)
                        .frame(width: 60, height: 60)
                        .background(.CustomPurple)
                        .overlay(Rectangle()
                            .strokeBorder(.gray, lineWidth: 1)
                        )
                        
                    }
                    .background(.CustomPink)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2, x: 2, y: 2)
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(.black, lineWidth: 1)
                    )
                    
                    Spacer()
                    
                    NavigationLink {
                        GameView(game: $game)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Play!")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(25)
                            .padding(.horizontal)
                            .background(.CustomGreen)
                            .cornerRadius(10)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(.black, lineWidth: 1)
                            )
                    }
                    
                    Spacer()
                }
                .labelsHidden()
            }
        }
    }
}

extension ShapeStyle where Self == Color {
    static var CustomBlue: Color {
        Color(red: 0.537, green: 0.820, blue: 0.863, opacity: 1.000)
    }
    
    static var CustomPink: Color {
        Color(red: 0.973, green: 0.612, blue: 0.980, opacity: 1.000)
    }
    
    static var CustomPurple: Color {
        Color(red: 0.765, green: 0.525, blue: 0.945, opacity: 1.000)
    }
    
    static var CustomYellow: Color {
        Color(red: 0.941, green: 0.839, blue: 0.537, opacity: 1.000)
    }
    
    static var CustomGreen: Color {
        Color(red: 0.686, green: 0.949, blue: 0.545, opacity: 1.000)
    }
    
    static var CustomRed: Color {
        Color(red: 0.957, green: 0.271, blue: 0.376, opacity: 1.000)
    }
}

#Preview {
    ContentView()
}
