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

final class ScheduleViewModel: ObservableObject {
    @Published var settlements: [SettlementsFromStationsList] = []
    private let dataProvider = DataProvider()
    
    init() {
        Task { await getSettlements() }
    }
    
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
