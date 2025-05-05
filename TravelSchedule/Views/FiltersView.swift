//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 10.04.2025.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    @EnvironmentObject private var filtersViewModel: FiltersViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(DepartureTime.allCases, id: \.self) { time in
                        CheckBox(title: time.rawValue, selected: filtersViewModel.departureTimes.contains(time))
                            .onTapGesture {
                                filtersViewModel.select(departureTime: time)
                            }
                    }
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(HasTransfer.allCases, id: \.self) { hasTransfer in
                        RadioSelect(title: hasTransfer.rawValue,
                                    selected: filtersViewModel.hasTransfers && hasTransfer == .yes ||
                                    !filtersViewModel.hasTransfers && hasTransfer == .no
                        )
                            .onTapGesture {
                                filtersViewModel.toggleTransfers()
                            }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    let filteredCarriers = filtersViewModel.filter(carriers: carriersViewModel.carriers)
                    carriersViewModel.setFilteredCarriers(filteredCarriers)
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
        .environmentObject(FiltersViewModel())
}
