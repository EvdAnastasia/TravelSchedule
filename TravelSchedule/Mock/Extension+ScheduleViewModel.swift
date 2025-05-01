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
        
        return viewModel
    }
}
