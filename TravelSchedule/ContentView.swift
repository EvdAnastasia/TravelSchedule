//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Get nearest stations") {
                getNearestStations()
            }
        }
        .padding()
    }
}

private func getNearestStations() {
    let client = createClient()
    guard let client else { return }
    
    let service = NearestStationsService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        let stations = try await service.getNearestStations(
            lat: 50.440046,
            lng: 40.4882367,
            distance: 50
        )
        print(stations)
    }
}

private func createClient() -> Client? {
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

#Preview {
    ContentView()
}
