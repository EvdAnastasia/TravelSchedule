//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Anastasiia on 21.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResult = Components.Schemas.SearchResult

protocol SearchServiceProtocol: Sendable {
    func getSearchResult(
        from: String,
        to: String,
        date: String?,
        transportType: String,
        hasTransfers: Bool
    ) async throws -> SearchResult
}

actor SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSearchResult(
        from: String,
        to: String,
        date: String? = nil,
        transportType: String,
        hasTransfers: Bool
    ) async throws -> SearchResult {
        let response = try await client.getSearchResult(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date ?? "",
            transport_types: transportType,
            transfers: String(hasTransfers)
        ))
        
        return try response.ok.body.json
    }
}
