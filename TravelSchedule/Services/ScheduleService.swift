//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Anastasiia on 21.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleInfo = Components.Schemas.ScheduleInfo

protocol ScheduleServiceProtocol {
    func getSchedule(station: String) async throws -> ScheduleInfo
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSchedule(station: String) async throws -> ScheduleInfo {
        let response = try await client.getSchedule(query: .init(
            apikey: apikey,
            station: station
        ))
        
        return try response.ok.body.json
    }
}
