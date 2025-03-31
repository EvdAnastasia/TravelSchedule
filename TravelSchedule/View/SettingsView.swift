//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 31.03.2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(Constants.isDarkMode) private var isDarkMode = false
    @State private var path: [String] = []
    
    var body: some View {
        NavigationStack(path: $path) {
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
                        path.append(Constants.userAgreementView)
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Text("Приложение использует API «Яндекс.Расписания»")
                        Text("Версия 1.0 (beta)")
                    }
                    .font(.system(size: 12, weight: .regular))
                }
                .navigationDestination(for: String.self) { id in
                    if id == Constants.userAgreementView {
                        UserAgreementView()
                            .toolbar(.hidden, for: .tabBar)
                    }
                }
                .foregroundStyle(.ypBlack)
                .padding([.top, .bottom], 24)
                .padding([.leading, .trailing], 16)
            }
        }
    }
}

#Preview {
    SettingsView()
}
