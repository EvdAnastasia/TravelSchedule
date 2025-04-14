//
//  RadioSelect.swift
//  TravelSchedule
//
//  Created by Anastasiia on 10.04.2025.
//

import SwiftUI

private enum RadioSelectConstants {
    static let selectedImageName = "largecircle.fill.circle"
    static let unselectedImageName = "circle"
}

struct RadioSelect: View {
    let title: String
    let selected: Bool
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            HStack {
                Text(title)
                Spacer()
                Image(systemName: selected ? RadioSelectConstants.selectedImageName : RadioSelectConstants.unselectedImageName)
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    VStack {
        RadioSelect(title: "title", selected: false)
        RadioSelect(title: "title", selected: true)
    }
    .padding()
}
