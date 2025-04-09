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

final class ScheduleViewModel: ObservableObject {
    @Published var settlements: [SettlementsFromStationsList] = []
    @Published var stations: [Stations] = []
    @Published var directionFrom = DirectionPath(settlement: nil, station: nil)
    @Published var directionTo = DirectionPath(settlement: nil, station: nil)
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
    
    func changeDirection() {
        swap(&directionFrom, &directionTo)
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
}
