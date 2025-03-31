//
//  MainView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI

struct MainView: View {
    @AppStorage(Constants.isDarkMode) private var isDarkMode = false
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .ypDivider
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
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
        .tint(.ypBlack)
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    MainView()
}
