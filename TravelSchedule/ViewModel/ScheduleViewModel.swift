//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Anastasiia on 04.04.2025.
//

import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

typealias SettlementsFromStationsList = Components.Schemas.SettlementsFromStationsList
typealias Stations = Components.Schemas.StationsFromStationsList
typealias Segments = Components.Schemas.Segments
typealias Carrier = Components.Schemas.Carrier

final class ScheduleViewModel: ObservableObject {
    @Published var settlements: [SettlementsFromStationsList] = []
    @Published var stations: [Stations] = []
    @Published var filteredCarriers: [Segments] = []
    @Published var directionFrom = DirectionPath(settlement: nil, station: nil)
    @Published var directionTo = DirectionPath(settlement: nil, station: nil)
    @Published var hasTransfers: Bool = true
    @Published var departureTimes: [DepartureTime] = []
    @Published var carrier: Carrier?
    
    private var carriers: [Segments] = []
    private let dataProvider = DataProvider()
    
    init() {
        Task { await getSettlements() }
    }
    
    var isSearchButtonEnabled: Bool {
        directionFrom.station != nil && directionTo.station != nil
    }
    
    func getStations(for settlement: SettlementsFromStationsList) {
        let allStations = settlement.stations ?? []
        stations = allStations.filter { $0.station_type == "train_station" || $0.transport_type == "train" }
        stations.sort {$0.title ?? "" < $1.title ?? "" }
    }
    
    func setSettlement(for direction: Direction, settlement: SettlementsFromStationsList) {
        switch direction {
        case .from:
            directionFrom.settlement = settlement
            directionFrom.station = nil
        case .to:
            directionTo.settlement = settlement
            directionTo.station = nil
        }
    }
    
    func setStation(for direction: Direction, station: Stations) {
        switch direction {
        case .from:
            directionFrom.station = station
        case .to:
            directionTo.station = station
        }
    }
    
    func setCarrier(_ newCarrier: Carrier?) {
        carrier = newCarrier
    }
    
    func changeDirection() {
        swap(&directionFrom, &directionTo)
    }
    
    func format(date: String, with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        return outputFormatter.string(from: dateFormatter.date(from: date) ?? Date())
    }
    
    func filter() {
        var newFilteredCarriers = carriers
        
        if !departureTimes.isEmpty {
            newFilteredCarriers = newFilteredCarriers.filter { segment in
                guard let departure = segment.departure else { return false }
                let hour = convertToHours(departure: departure)
                
                switch hour {
                case 6..<12: return departureTimes.contains(.morning)
                case 12..<18: return departureTimes.contains(.afternoon)
                case 18...23: return departureTimes.contains(.evening)
                case 0..<6: return departureTimes.contains(.night)
                default: return false
                }
            }
        }
        
        if !hasTransfers {
            newFilteredCarriers = newFilteredCarriers.filter {$0.has_transfers == false }
        }
        
        filteredCarriers = newFilteredCarriers
    }
    
    func select(departureTime: DepartureTime) {
        if !departureTimes.contains(departureTime) {
            departureTimes.append(departureTime)
        } else {
            departureTimes = departureTimes.filter { $0 != departureTime}
        }
    }
    
    func selectTransfer() {
        hasTransfers.toggle()
    }
    
    @MainActor
    func search() async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        guard let fromCode = directionFrom.station?.codes?.yandex_code,
              let toCode = directionTo.station?.codes?.yandex_code else { return }
        
        do {
            let searchResult = try await dataProvider.getSearchResult(
                fromCode: fromCode,
                toCode: toCode,
                date: date,
                transportType: "train",
                hasTransfers: true
            )
            
            carriers = searchResult.segments ?? []
            filteredCarriers = carriers
        } catch {
            print(String(describing: error))
        }
    }
    
    @MainActor
    private func getSettlements() async {
        do {
            let allStations = try await dataProvider.getStationsList()
            
            settlements = allStations.countries?
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
                .filter {
                    guard let title = $0.title else { return false }
                    return MockData.settlements.contains(title) && !title.isEmpty
                }
                .sorted { $0.title ?? "" < $1.title ?? "" } ?? []
            
        } catch {
            print("Error fetching settlements: \(error)")
        }
    }
    
    private func convertToHours(departure: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let hour = Calendar.current.component(.hour, from: dateFormatter.date(from: departure) ?? Date())
        return hour
    }
}
