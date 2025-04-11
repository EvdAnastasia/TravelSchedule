//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 10.04.2025.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject var routerManager: NavigationRouter
    @EnvironmentObject private var viewModel: ScheduleViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(DepartureTime.allCases, id: \.self) { time in
                        CheckBox(title: time.rawValue, selected: viewModel.departureTimes.contains(time))
                            .onTapGesture {
                                viewModel.select(departureTime: time)
                            }
                    }
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(HasTransfer.allCases, id: \.self) { hasTransfer in
                        RadioSelect(title: hasTransfer.rawValue,
                                    selected: viewModel.hasTransfers && hasTransfer == .yes ||
                                    !viewModel.hasTransfers && hasTransfer == .no
                        )
                            .onTapGesture {
                                viewModel.selectTransfer()
                            }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.filter()
                    routerManager.navigateBack()
                }) {
                    Text("Применить")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(.ypWhiteUniversal)
                        .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
                }
                .background(.ypBlue)
                .clipShape(.rect(cornerRadius: 16))
                .padding(.bottom, 24)
            }
            .padding(16)
        }
    }
}

#Preview {
    FiltersView()
}
