//
//  Route.swift
//  TravelSchedule
//
//  Created by Anastasiia on 02.04.2025.
//

import SwiftUI

enum Route: Hashable {
    case userAgreement
    case citySelection(direction: Direction)
    case stationSelection(direction: Direction)
}

extension Route: View {
    var body: some View {
        switch self {
        case .userAgreement:
            UserAgreementView()
                .toolbarRole(.editor)
        case .citySelection(let direction):
            CitySelectionView(direction: direction)
                .toolbarRole(.editor)
        case .stationSelection(let direction):
            StationSelectionView(direction: direction)
                .toolbarRole(.editor)
        }
    }
}
