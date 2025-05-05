//
//  FiltersViewModel.swift
//  TravelSchedule
//
//  Created by Anastasiia on 29.04.2025.
//

import Foundation

@MainActor
final class FiltersViewModel: ObservableObject {
    @Published var hasTransfers: Bool = true
    @Published var departureTimes: [DepartureTime] = []
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    func filter(carriers: [Segments]) -> [Segments] {
        var newFilteredCarriers = carriers
        
        if !departureTimes.isEmpty {
            newFilteredCarriers = newFilteredCarriers.filter { segment in
                guard let departure = segment.departure else { return false }
                let hour = convertToHours(departure: departure)
                return matchesDepartureTime(hour)
            }
        }
        
        if !hasTransfers {
            newFilteredCarriers = newFilteredCarriers.filter {$0.has_transfers == false }
        }
        
        return newFilteredCarriers
    }
    
    func select(departureTime: DepartureTime) {
        if !departureTimes.contains(departureTime) {
            departureTimes.append(departureTime)
        } else {
            departureTimes = departureTimes.filter { $0 != departureTime}
        }
    }
    
    func toggleTransfers() {
        hasTransfers.toggle()
    }
    
    private func convertToHours(departure: String) -> Int {
        guard let date = dateFormatter.date(from: departure) else { return -1 }
        return Calendar.current.component(.hour, from: date)
    }
    
    private func matchesDepartureTime(_ hour: Int) -> Bool {
        switch hour {
        case 6..<12: return departureTimes.contains(.morning)
        case 12..<18: return departureTimes.contains(.afternoon)
        case 18...23: return departureTimes.contains(.evening)
        case 0..<6: return departureTimes.contains(.night)
        default: return false
        }
    }
}
