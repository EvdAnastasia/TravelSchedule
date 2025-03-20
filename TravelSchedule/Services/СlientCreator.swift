//
//  СlientCreator.swift
//  TravelSchedule
//
//  Created by Anastasiia on 20.03.2025.
//

import Foundation
import OpenAPIURLSession

final class СlientCreator {
    static func create() -> Client? {
        var url: URL?
        
        do {
            url = try Servers.Server1.url()
        } catch {
            print(String(describing: error))
        }
        
        guard let url else { return nil }
        
        let client = Client(
            serverURL: url,
            transport: URLSessionTransport()
        )
        
        return client
    }
}
