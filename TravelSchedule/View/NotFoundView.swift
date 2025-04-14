//
//  NotFoundView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 06.04.2025.
//

import SwiftUI

struct NotFoundView: View {
    let text: String
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            Text(text)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}

#Preview {
    NotFoundView(text: "Город не найден")
}
