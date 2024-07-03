//
//  CrewRoster.swift
//  Moonshot
//
//  Created by Daehoon Lee on 7/3/24.
//

import SwiftUI

struct CrewRoster: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

#Preview {
    let crew = [MissionView.CrewMember(role: "Commander", astronaut: Astronaut(id: "armstrong", name: "Neil A. Armstrong", description: ""))]
    
    return CrewRoster(crew: crew)
        .preferredColorScheme(.dark)
}
