//
//  DataProvider.swift
//  TravelSchedule
//
//  Created by Anastasiia on 04.04.2025.
//

import Foundation

final class DataProvider {
    
    func getStationsList() async throws -> StationsList {
        let client = СlientCreator.create()
        guard let client else { return StationsList() }
        
        let service = StationsListService(
            client: client,
            apikey: ServicesConstants.apikey
        )
        guard let stationsList = try await service.getStationsList() else { return StationsList() }
        return stationsList
    }
}
