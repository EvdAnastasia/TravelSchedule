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
            
            Button("Get copyright") {
                getCopyright()
            }
            
            Button("Get search result") {
                getSearchResult()
            }
            
            Button("Get schedule") {
                getSchedule()
            }
            
            Button("Get thread") {
                getThread()
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

private func getCopyright() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = CopyrightService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let copyright = try await service.getCopyright()
            print(copyright)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

private func getSearchResult() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = SearchService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let searchResult = try await service.getSearchResult(
                from: "c146",
                to: "c213",
                date: "2025-03-16"
            )
            print(searchResult)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

private func getSchedule() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = ScheduleService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let schedule = try await service.getSchedule(station: "s9600213")
            print(schedule)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

private func getThread() {
    let client = СlientCreator.create()
    guard let client else { return }
    
    let service = ThreadService(
        client: client,
        apikey: ServicesConstants.apikey
    )
    
    Task {
        do {
            let thread = try await service.getThread(uid: "092S_7_2")
            print(thread)
        } catch {
            print("error response: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
