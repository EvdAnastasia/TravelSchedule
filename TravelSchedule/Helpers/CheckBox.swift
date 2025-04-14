//
//  CheckBox.swift
//  TravelSchedule
//
//  Created by Anastasiia on 10.04.2025.
//

import SwiftUI

private enum CheckBoxConstants {
    static let selectedImageName = "checkmark.square.fill"
    static let unselectedImageName = "square"
}

struct CheckBox: View {
    let title: String
    let selected: Bool
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            HStack {
                Text(title)
                Spacer()
                Image(systemName: selected ? CheckBoxConstants.selectedImageName : CheckBoxConstants.unselectedImageName)
                    .frame(width: 20, height: 20)
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    VStack {
        CheckBox(title: "title", selected: false)
        CheckBox(title: "title", selected: true)
    }
    .padding()
}
