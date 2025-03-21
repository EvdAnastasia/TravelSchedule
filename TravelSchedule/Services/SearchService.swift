//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Anastasiia on 21.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResult = Components.Schemas.SearchResult

protocol SearchServiceProtocol {
    func getSearchResult(from: String, to: String, date: String) async throws -> SearchResult
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getSearchResult(from: String, to: String, date: String) async throws -> SearchResult {
        let response = try await client.getSearchResult(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date
        ))
        
        return try response.ok.body.json
    }
}
