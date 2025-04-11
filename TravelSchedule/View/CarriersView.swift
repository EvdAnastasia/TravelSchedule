//
//  CarriersView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 09.04.2025.
//

import SwiftUI

struct CarriersView: View {
    @EnvironmentObject var routerManager: NavigationRouter
    @EnvironmentObject private var viewModel: ScheduleViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(spacing: 16) {
                Group {
                    Text("\(viewModel.directionFrom.settlement?.title ?? "")" +
                         " (\(viewModel.directionFrom.station?.title ?? "")) ") +
                    Text("\(UnicodeScalar(0x2192)!) ") +
                    Text("\(viewModel.directionTo.settlement?.title ?? "")" +
                         " (\(viewModel.directionTo.station?.title ?? "")) ")
                }
                .font(.system(size: 24, weight: .bold))
                
                if !viewModel.filteredCarriers.isEmpty {
                    ZStack(alignment: .bottom) {
                        ScrollView {
                            LazyVStack(spacing: 8) {
                                ForEach(viewModel.filteredCarriers, id: \.self) { segment in
                                    CarrierCardView(
                                        segmentInfo: segment,
                                        startDate: viewModel.format(date: segment.start_date ?? "", with: "dd MMMM"),
                                        departure: viewModel.format(date: segment.departure ?? "", with: "HH:mm"),
                                        arrival: viewModel.format(date: segment.arrival ?? "", with: "HH:mm")
                                    )
                                    .frame(height: 104)
                                    .onTapGesture {
                                        viewModel.setCarrier(segment.thread?.carrier)
                                        routerManager.push(to: .carrierInfo)
                                    }
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                        
                        VStack {
                            Spacer()
                            
                            Button {
                                routerManager.push(to: .filters)
                            } label: {
                                HStack {
                                    Text("Уточнить время")
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundStyle(.ypWhiteUniversal)
                                    Circle()
                                        .frame(width: 8, height: 8)
                                        .foregroundStyle(viewModel.departureTimes.isEmpty && viewModel.hasTransfers ? .ypBlue : .ypRed)
                                }
                            }
                            .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
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
}

#Preview {
    CarriersView()
}
