//
//  ChoiceImage.swift
//  RockPaperScissors
//
//  Created by Daehoon Lee on 6/16/24.
//

import SwiftUI

struct ChoiceImage: View {
    var choice: String
    var width: CGFloat
    
    init(of choice: String, _ width: CGFloat) {
        self.choice = choice
        self.width = width
    }
    
    var body: some View {
        Image(choice)
            .resizable()
            .scaledToFit()
            .frame(width: width)
    }
}

#Preview {
    ChoiceImage(of: "rock", 256)
}
