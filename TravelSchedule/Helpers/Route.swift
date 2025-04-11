//
//  Route.swift
//  TravelSchedule
//
//  Created by Anastasiia on 02.04.2025.
//

import SwiftUI

enum Route: Hashable {
    case userAgreement
    case carriers
    case carrierInfo
    case filters
    case citySelection(direction: Direction)
    case stationSelection(direction: Direction)
}

extension Route: View {
    var body: some View {
        switch self {
        case .userAgreement:
            UserAgreementView()
                .toolbarRole(.editor)
        case .carriers:
            CarriersView()
                .toolbarRole(.editor)
        case .carrierInfo:
            CarrierInfoView()
                .toolbarRole(.editor)
        case .filters:
            FiltersView()
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
