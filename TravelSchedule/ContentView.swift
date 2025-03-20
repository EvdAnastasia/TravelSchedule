//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Get nearest stations") {
                getNearestStations()
            }
            
            Button("Get nearest settlement") {
                getNearestSettlement()
            }
            
            Button("Get carriers") {
                getCarriers()
            }
            
            Button("Get stations list") {
                getStationsList()
            }
        }
        .padding()
    }
}

private func getNearestStations() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = NearestStationsService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let stations = try await service.getNearestStations(
                lat: 50.440046,
                lng: 40.4882367,
                distance: 50
            )
            print(stations)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

private func getNearestSettlement() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = NearestSettlementService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let settlement = try await service.getNearestSettlement(
                lat: 50.440046,
                lng: 40.4882367,
                distance: 50
            )
            print(settlement)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

private func getCarriers() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = CarriersService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let carriers = try await service.getCarriers(
                code: "TK",
                system: "iata"
            )
            print(carriers)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

private func getStationsList() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = StationsListService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let stationsList = try await service.getStationsList()
            guard let stationsList else { return }
            print(stationsList)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
