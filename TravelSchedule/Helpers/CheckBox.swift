//
//  CheckBox.swift
//  TravelSchedule
//
//  Created by Anastasiia on 10.04.2025.
//

import SwiftUI

struct CheckBox: View {
    let title: String
    let selected: Bool
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            HStack {
                Text(title)
                Spacer()
                Image(systemName: selected ? "checkmark.square.fill" : "square")
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    CheckBox(title: "", selected: false)
}
