//
//  HeaderView.swift
//  iExpense
//
//  Created by Daehoon Lee on 6/29/24.
//

import SwiftUI

struct HeaderView: View {
    let types = ["Business", "Personal"]
    let headerTitle: String
    
    var body: some View {
        Text("\(headerTitle) \(headerTitle == "Personal" ? "🛍️" : "💼")")
            .font(.title2.bold())
            .foregroundStyle(.blue)
    }
}

#Preview {
    HeaderView(headerTitle: "Business")
}
