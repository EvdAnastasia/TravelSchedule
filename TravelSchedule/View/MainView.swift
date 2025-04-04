//
//  MainView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var routerManager = NavigationRouter()
    @AppStorage(Constants.isDarkMode) private var isDarkMode = false
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .ypDivider
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            TabView {
                ScheduleView()
                    .tabItem {
                        Image("Schedule")
                            .renderingMode(.template)
                    }
                
                SettingsView()
                    .tabItem {
                        Image("Settings")
                            .renderingMode(.template)
                    }
            }
            .environmentObject(routerManager)
            .navigationDestination(for: Route.self) { $0 }
        }
        .tint(.ypBlack)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainView()
}
