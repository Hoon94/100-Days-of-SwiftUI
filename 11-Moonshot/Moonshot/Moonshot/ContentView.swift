//
//  ContentView.swift
//  Moonshot
//
//  Created by Daehoon Lee on 6/30/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("showingGrid") private var showingGrid = true
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            Group {
                if showingGrid {
                    GridLayout(astronauts: astronauts, missions: missions)
                } else {
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    withAnimation {
                        showingGrid.toggle()
                    }
                } label: {
                    Image(systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
