//
//  Extension+ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Anastasiia on 14.04.2025.
//

import Foundation

extension ScheduleViewModel {
    static var mock: ScheduleViewModel {
        let viewModel = ScheduleViewModel()
        
        viewModel.directionFrom = DirectionPath(
            settlement: SettlementsFromStationsList(title: "Москва"),
            station: Stations(codes: .init(yandex_code: "s9602490"), title: "Киевская")
        )
        viewModel.directionTo = DirectionPath(
            settlement: SettlementsFromStationsList(title: "Сочи"),
            station: Stations(codes: .init(yandex_code: "s9603772"), title: "Адлер")
        )
        
        let carrier = Carrier(title: "РЖД", logo: nil)
        
        var segment = Segments()
        segment.thread = .init(carrier: carrier)
        segment.start_date = "2025-04-15T00:00:00+0300"
        segment.departure = "2025-04-15T07:00:00+0300"
        segment.arrival = "2025-04-15T12:00:00+0300"
        segment.duration = 18000
        segment.has_transfers = true
        segment.transfers = [.init(title: "Воронеж")]
        
        viewModel.filteredCarriers = [segment]
        viewModel.hasTransfers = true
        viewModel.departureTimes = [.morning]
        viewModel.carrier = carrier
        
        return viewModel
    }
}
