//
//  CustomDivider.swift
//  Moonshot
//
//  Created by Daehoon Lee on 7/3/24.
//

import SwiftUI

struct CustomDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}

#Preview {
    CustomDivider()
}
