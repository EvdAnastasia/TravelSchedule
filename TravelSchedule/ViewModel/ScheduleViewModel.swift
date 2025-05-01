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

@MainActor
final class ScheduleViewModel: ObservableObject {
    
    // MARK: - UI Binding
    
    @Published var settlements: [SettlementsFromStationsList] = []
    @Published var stations: [Stations] = []
    @Published var directionFrom = DirectionPath(settlement: nil, station: nil)
    @Published var directionTo = DirectionPath(settlement: nil, station: nil)
    @Published var state: AppState = .loading
    
    private let dataProvider = DataProvider()
    
    var isSearchButtonEnabled: Bool {
        directionFrom.station != nil && directionTo.station != nil
    }
    
    // MARK: - Request data
    
    func getSettlements() async {
        state = .loading
        
        do {
            let allStations = try await dataProvider.getStationsList()
            
            settlements = allStations.countries?
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
                .filter {
                    guard let title = $0.title else { return false }
                    return SettlementsMock.data.contains(title) && !title.isEmpty
                }
                .sorted { $0.title ?? "" < $1.title ?? "" } ?? []
            state = .success
        } catch ErrorType.internetConnectionError {
            state = .error(.internetConnectionError)
        } catch ErrorType.serverError {
            state = .error(.serverError)
        } catch {
            print("Error fetching settlements: \(error)")
        }
    }
    
    func getStations(for settlement: SettlementsFromStationsList) {
        let allStations = settlement.stations ?? []
        stations = allStations.filter { $0.station_type == "train_station" || $0.transport_type == "train" }
        stations.sort {$0.title ?? "" < $1.title ?? "" }
    }
    
    // MARK: - Direction Handling
    
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
    
    func changeDirection() {
        swap(&directionFrom, &directionTo)
    }
    
    // MARK: - Search
    
    func search() async -> [Segments] {
        state = .loading
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        guard let fromCode = directionFrom.station?.codes?.yandex_code,
              let toCode = directionTo.station?.codes?.yandex_code else { return [] }
        
        do {
            let searchResult = try await dataProvider.getSearchResult(
                fromCode: fromCode,
                toCode: toCode,
                date: date,
                transportType: "train",
                hasTransfers: true
            )
            state = .success
            return searchResult.segments ?? []
        } catch ErrorType.internetConnectionError {
            state = .error(.internetConnectionError)
        } catch ErrorType.serverError {
            state = .error(.serverError)
        } catch {
            print("Searching error: \(error)")
        }
        
        return []
    }
    
    // MARK: - Data Converting
    
    func format(date: String, with format: String) -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = format
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        return outputFormatter.string(from: CustomDateFormatter.dateParser.date(from: date) ?? Date())
    }
}
