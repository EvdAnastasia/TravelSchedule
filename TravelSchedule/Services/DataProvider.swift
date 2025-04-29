//
//  DataProvider.swift
//  TravelSchedule
//
//  Created by Anastasiia on 04.04.2025.
//

import Foundation

actor DataProvider: Sendable {
    
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
    
    func getSearchResult(
        fromCode: String,
        toCode: String,
        date: String? = nil,
        transportType: String,
        hasTransfers: Bool
    ) async throws -> SearchResult {
        let client = СlientCreator.create()
        guard let client else { return SearchResult() }
        
        let service = SearchService(
            client: client,
            apikey: ServicesConstants.apikey
        )
        
        return try await service.getSearchResult(
            from: fromCode,
            to: toCode,
            date: date,
            transportType: transportType,
            hasTransfers: hasTransfers
        )
    }
}
