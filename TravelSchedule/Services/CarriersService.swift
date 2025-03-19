//
//  CarriersService.swift
//  TravelSchedule
//
//  Created by Anastasiia on 19.03.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Carriers = Components.Schemas.Carriers

protocol CarriersServiceProtocol {
    func getCarriers(code: String, system: String) async throws -> Carriers
}

final class CarriersService: CarriersServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getCarriers(code: String, system: String) async throws -> Carriers {
        let response = try await client.getCarriers(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        
        return try response.ok.body.json
    }
}
