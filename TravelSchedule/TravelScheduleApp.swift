//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @StateObject private var scheduleViewModel = ScheduleViewModel()
    @StateObject private var filtersViewModel = FiltersViewModel()
    @StateObject private var carriersViewModel = CarriersViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(scheduleViewModel)
                .environmentObject(filtersViewModel)
                .environmentObject(carriersViewModel)
        }
    }
}
