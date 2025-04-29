//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Anastasiia on 20.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol: Sendable {
    func getStationsList() async throws -> StationsList?
}

actor StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getStationsList() async throws -> StationsList? {
        let response = try await client.getStationsList(query: .init(
            apikey: apikey
        ))
        
        let htmlResponse = try response.ok.body.html
        let data = try await Data(collecting: htmlResponse, upTo: .max)
        
        do {
            let stationsList = try JSONDecoder().decode(StationsList.self, from: data)
            return stationsList
        } catch {
            print(String(describing: error))
            return nil
        }
    }
}
