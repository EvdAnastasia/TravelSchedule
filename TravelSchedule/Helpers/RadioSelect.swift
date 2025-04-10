//
//  RadioSelect.swift
//  TravelSchedule
//
//  Created by Anastasiia on 10.04.2025.
//

import SwiftUI

struct RadioSelect: View {
    let title: String
    let selected: Bool
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            HStack {
                Text(title)
                Spacer()
                Image(systemName: selected ? "largecircle.fill.circle" : "circle")
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    RadioSelect(title: "", selected: false)
}
