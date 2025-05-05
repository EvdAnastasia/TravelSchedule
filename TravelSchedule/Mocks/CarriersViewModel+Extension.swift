//
//  CarriersViewModel+Extension.swift
//  TravelSchedule
//
//  Created by Anastasiia on 01.05.2025.
//

import Foundation

extension CarriersViewModel {
    static var mock: CarriersViewModel {
        let carrier = Carrier(title: "РЖД", logo: nil)
        let segment = makeSegment(with: carrier)
        
        let viewModel = CarriersViewModel()
        viewModel.filteredCarriers = [segment]
        viewModel.carrier = carrier
        return viewModel
    }
    
    private static func makeSegment(with carrier: Carrier) -> Segments {
        var segment = Segments()
        segment.thread = .init(carrier: carrier)
        segment.start_date = "2025-04-15T00:00:00+0300"
        segment.departure = "2025-04-15T07:00:00+0300"
        segment.arrival = "2025-04-15T12:00:00+0300"
        segment.duration = 18000
        segment.has_transfers = true
        segment.transfers = [.init(title: "Воронеж")]
        return segment
    }
}
