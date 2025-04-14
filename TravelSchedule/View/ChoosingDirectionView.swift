//
//  ChoosingDirectionView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 02.04.2025.
//

import SwiftUI

struct ChoosingDirectionView: View {
    let path: DirectionPath
    let placeholder: String
    
    private var displayText: String {
        if let settlement = path.settlement?.title,
           let station = path.station?.title {
            return "\(settlement) (\(station))"
        } else {
            return placeholder
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.ypWhiteUniversal.ignoresSafeArea()
            
            Text(displayText)
                .padding(.leading, 13)
                .padding(.trailing, 16)
                .lineLimit(1)
                .foregroundStyle(displayText == placeholder ? .ypGray : .ypBlackUniversal)
        }
        .cornerRadius(20)
    }
}

#Preview {
    VStack(spacing: 12) {
        ChoosingDirectionView(
            path: DirectionPath(settlement: nil, station: nil),
            placeholder: "Откуда"
        )
        
        ChoosingDirectionView(
            path: DirectionPath(
                settlement: SettlementsFromStationsList(title: "Москва"),
                station: Stations(codes: .init(yandex_code: "s9602490"), title: "Киевская")
            ),
            placeholder: "Откуда"
        )
        
        ChoosingDirectionView(
            path: DirectionPath(
                settlement: SettlementsFromStationsList(title: "Санкт-Петербург"),
                station: nil
            ),
            placeholder: "Куда"
        )
    }
    .padding()
    .background(Color.gray.opacity(0.05))
}
