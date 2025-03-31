//
//  MainView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI

struct MainView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .ypDivider
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        ZStack(alignment: .top) {
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
        }
    }
}

#Preview {
    MainView()
}
