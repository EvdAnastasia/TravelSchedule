//
//  CarriersViewModel.swift
//  TravelSchedule
//
//  Created by Anastasiia on 01.05.2025.
//

import Foundation

@MainActor
final class CarriersViewModel: ObservableObject {
    
    @Published var carrier: Carrier?
    @Published var carriers: [Segments] = []
    @Published var filteredCarriers: [Segments] = []
    
    func setCarrier(_ newCarrier: Carrier?) {
        carrier = newCarrier
    }
    
    func setCarriers(_ newCarriers: [Segments]) {
        carriers = newCarriers
    }
    
    func setFilteredCarriers(_ newCarriers: [Segments]) {
        filteredCarriers = newCarriers
    }
}
