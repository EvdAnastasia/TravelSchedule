//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    @StateObject private var viewModel = ScheduleViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(viewModel)
        }
    }
}
