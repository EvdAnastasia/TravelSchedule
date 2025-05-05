//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 31.03.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @AppStorage(Constants.isDarkMode) private var isDarkMode = false
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack {
                Toggle("Темная тема", isOn: $isDarkMode)
                    .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
                    .frame(height: 60)
                
                HStack() {
                    Text("Пользовательское соглашение")
                    Spacer()
                    Image("Chevron")
                }
                .frame(height: 60)
                .onTapGesture {
                    routerManager.push(to: .userAgreement)
                }
                
                Spacer()
                
                VStack(spacing: 16) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                    Text("Версия 1.0 (beta)")
                }
                .font(.system(size: 12, weight: .regular))
            }
            .foregroundStyle(.ypBlack)
            .padding([.top, .bottom], 24)
            .padding([.leading, .trailing], 16)
        }
    }
}

#Preview {
    SettingsView()
}
