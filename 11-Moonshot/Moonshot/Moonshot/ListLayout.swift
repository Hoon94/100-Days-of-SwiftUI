//
//  ListLayout.swift
//  Moonshot
//
//  Created by Daehoon Lee on 7/3/24.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink(value: mission) {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .padding()
                        
                        VStack(alignment: .leading) {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                                .padding(.top, -5)
                        }
                    }
                }
                .padding(.horizontal)
                .navigationDestination(for: Mission.self) {
                    MissionView(mission: $0, astronauts: astronauts)
                }
                .listRowBackground(Color.darkBackground)
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 3, leading: 15, bottom: 3, trailing: 15))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.lightBackground)
                )
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    return ListLayout(astronauts: astronauts, missions: missions)
        .preferredColorScheme(.dark)
}
