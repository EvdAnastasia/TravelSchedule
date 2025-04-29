//
//  MainView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.03.2025.
//

import SwiftUI

struct MainView: View {
    @StateObject private var routerManager = NavigationRouter()
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @AppStorage(Constants.isDarkMode) private var isDarkMode = false
    
    // MARK: - Init
    
    init() {
        configureTabBarAppearance()
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack(path: $routerManager.routes) {
            tabBar
            .navigationDestination(for: Route.self) { $0 }
        }
        .environmentObject(routerManager)
        .tint(.ypBlack)
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .task {
            await viewModel.getSettlements()
        }
    }
    
    // MARK: - Content
    
    private var tabBar: some View {
        TabView {
            ScheduleView()
                .tabItem {
                    Image("Schedule").renderingMode(.template)
                }
            
            SettingsView()
                .tabItem {
                    Image("Settings").renderingMode(.template)
                }
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .ypDivider
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

#Preview {
    MainView()
        .environmentObject(ScheduleViewModel())
}
