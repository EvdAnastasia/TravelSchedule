//
//  DepartureTime.swift
//  TravelSchedule
//
//  Created by Anastasiia on 10.04.2025.
//

import Foundation

enum DepartureTime: String, CaseIterable {
    case morning = "Утро 06:00 - 12:00"
    case afternoon = "День 12:00 - 18:00"
    case evening = "Вечер 18:00 - 00:00"
    case night = "Ночь 00:00 - 06:00"
}
