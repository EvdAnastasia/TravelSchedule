//
//  ChoosingDirectionView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 02.04.2025.
//

import SwiftUI

struct ChoosingDirectionView: View {
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.ypWhiteUniversal.ignoresSafeArea()
            
            Text(placeholder)
                .padding(.leading, 13)
                .padding(.trailing, 16)
                .lineLimit(1)
                .foregroundStyle(.ypGray)
        }
        .cornerRadius(20)
    }
}

#Preview {
    ChoosingDirectionView(placeholder: "Откуда")
}
