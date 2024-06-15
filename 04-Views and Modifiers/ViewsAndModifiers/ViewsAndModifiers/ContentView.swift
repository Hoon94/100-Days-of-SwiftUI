//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Daehoon Lee on 6/14/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RadialGradient(colors: [.teal, .black], center: .top, startRadius: 20, endRadius: 300)
            
            Text("Prominent Title")
                .titleStyle()
        }
        .ignoresSafeArea()
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.blue)
            .shadow(color: .white, radius: 20)
            .padding()
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

#Preview {
    ContentView()
}
