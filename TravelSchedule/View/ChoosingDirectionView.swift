//
//  ChoosingDirectionView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 02.04.2025.
//

import SwiftUI

struct ChoosingDirectionView: View {
    let text: String
    let placeholder: String
    
    init(path: DirectionPath, placeholder: String) {
        self.text = (path.settlement?.title.flatMap { settlementTitle in
            path.station?.title.map { stationTitle in
                "\(settlementTitle) (\(stationTitle))"
            }
        }) ?? placeholder
        
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.ypWhiteUniversal.ignoresSafeArea()
            
            Text(text)
                .padding(.leading, 13)
                .padding(.trailing, 16)
                .lineLimit(1)
                .foregroundStyle(text != placeholder ? .ypBlackUniversal : .ypGray)
        }
        .cornerRadius(20)
    }
}

#Preview {
    ChoosingDirectionView(
        path: DirectionPath(settlement: nil, station: nil),
        placeholder: "Откуда"
    )
}
