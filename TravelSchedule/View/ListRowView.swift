//
//  ListRowView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 04.04.2025.
//

import SwiftUI

struct ListRowView: View {
    var settlement: String

        var body: some View {
            ZStack {
                Color.ypWhite.ignoresSafeArea()
                HStack {
                    Text(settlement)
                        .font(.system(size: 17, weight: .regular))
                        .padding([.top, .bottom], 19)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .imageScale(.large)
                }
                .foregroundStyle(.ypBlack)
            }
        }
}

#Preview {
    ListRowView(settlement: "Москва")
}
