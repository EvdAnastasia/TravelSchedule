//
//  CarriersView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 09.04.2025.
//

import SwiftUI

struct CarriersView: View {
    @EnvironmentObject private var routerManager: NavigationRouter
    @EnvironmentObject private var scheduleViewModel: ScheduleViewModel
    @EnvironmentObject private var filtersViewModel: FiltersViewModel
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            switch scheduleViewModel.state {
            case .loading:
                ProgressView()
            case .success:
                content
            case .error(let error):
                GenericErrorView(type: error)
            }
        }
    }
    
    // MARK: - Content
    
    private var content: some View {
        VStack(spacing: 16) {
            Group {
                Text("\(scheduleViewModel.directionFrom.settlement?.title ?? "")" +
                     " (\(scheduleViewModel.directionFrom.station?.title ?? "")) ") +
                Text("\(UnicodeScalar(0x2192)!) ") +
                Text("\(scheduleViewModel.directionTo.settlement?.title ?? "")" +
                     " (\(scheduleViewModel.directionTo.station?.title ?? "")) ")
            }
            .font(.system(size: 24, weight: .bold))
            
            if !carriersViewModel.filteredCarriers.isEmpty {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        LazyVStack(spacing: 8) {
                            ForEach(carriersViewModel.filteredCarriers, id: \.self) { segment in
                                CarrierCardView(
                                    segmentInfo: segment,
                                    startDate: scheduleViewModel.format(date: segment.start_date ?? "", with: "dd MMMM"),
                                    departure: scheduleViewModel.format(date: segment.departure ?? "", with: "HH:mm"),
                                    arrival: scheduleViewModel.format(date: segment.arrival ?? "", with: "HH:mm")
                                )
                                .frame(height: 104)
                                .onTapGesture {
                                    carriersViewModel.setCarrier(segment.thread?.carrier)
                                    routerManager.push(to: .carrierInfo)
                                }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            routerManager.push(to: .filters)
                        }) {
                            HStack {
                                Text("Уточнить время")
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundStyle(.ypWhiteUniversal)
                                Circle()
                                    .frame(width: 8, height: 8)
                                    .foregroundStyle(filtersViewModel.departureTimes.isEmpty && filtersViewModel.hasTransfers ? .ypBlue : .ypRed)
                            }
                            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
                        }
                        .background(.ypBlue)
                        .clipShape(.rect(cornerRadius: 16))
                        .padding(.bottom, 8)
                    }
                }
            } else {
                Spacer()
                NotFoundView(text: "Вариантов нет")
            }
            Spacer()
        }
        .foregroundStyle(.ypBlack)
        .padding(16)
    }
}

#Preview {
    CarriersView()
}
