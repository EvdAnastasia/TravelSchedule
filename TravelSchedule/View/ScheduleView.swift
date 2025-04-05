//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 31.03.2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var routerManager: NavigationRouter
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(spacing: 16) {
                ZStack {
                    Color.ypBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 0) {
                            ChoosingDirectionView(placeholder: "Откуда")
                                .onTapGesture {
                                    routerManager.push(to: .citySelection)
                                }
                            ChoosingDirectionView(placeholder: "Куда")
                                .onTapGesture {
                                    routerManager.push(to: .citySelection)
                                }
                        }
                        .font(.system(size: 17, weight: .regular))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.ypWhiteUniversal)
                        )
                        
                        Button {
                            
                        } label: {
                            Image("Change")
                                .frame(width: 36, height: 36)
                                .background(.ypWhiteUniversal)
                                .cornerRadius(40)
                        }
                    }
                    .padding(16)
                }
                .cornerRadius(20)
                .padding(.horizontal, 16)
                .frame(height: 128)
                
                Button {
                    
                } label: {
                    Text("Найти")
                        .frame(width: 150, height: 60)
                        .font(.system(size: 17, weight: .bold))
                        .background(.ypBlue)
                        .foregroundStyle(.ypWhiteUniversal)
                        .cornerRadius(16)
                }
                .opacity(0)
            }
        }
    }
}

#Preview {
    ScheduleView()
}
