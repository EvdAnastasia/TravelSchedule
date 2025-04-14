//
//  CarrierCardView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 09.04.2025.
//

import SwiftUI

struct CarrierCardView: View {
    
    // MARK: - Properties
    
    private let segment: Segments
    private let startDate: String
    private let departure: String
    private let arrival: String
    private let travelTime: Double
    
    // MARK: - Init
    
    init(segmentInfo: Segments, startDate: String, departure: String, arrival: String) {
        self.segment = segmentInfo
        self.startDate = startDate
        self.departure = departure
        self.arrival = arrival
        travelTime = (segment.duration ?? 0)/3600
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.ypLightGrayUniversal
            content
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    // MARK: - Content
    
    private var content: some View {
        VStack(spacing: 14) {
            header
            routeInfo
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
    
    // MARK: - Subviews
    
    private var header: some View {
        HStack(alignment: .center, spacing: 18) {
            carrierLogo
            carrierTitleAndTransfer
            Spacer()
            Text(startDate)
                .font(.system(size: 12, weight: .regular))
        }
        .foregroundStyle(.ypBlackUniversal)
    }
    
    private var carrierLogo: some View {
        AsyncImage(url: URL(string: segment.thread?.carrier?.logo ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
            default:
                Image(systemName: "photo")
                    .font(.largeTitle)
            }
        }
        .frame(width: 38, height: 38)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var carrierTitleAndTransfer: some View {
        VStack(alignment: .leading) {
            Text(segment.thread?.carrier?.title ?? "Нет информации")
                .font(.system(size: 17, weight: .regular))
            if segment.has_transfers ?? false {
                Text("C пересадкой в: \(segment.transfers?.first?.title ?? "")")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundStyle(.ypRed)
                    .lineLimit(2)
            }
        }
    }
    
    private var routeInfo: some View {
        HStack {
            Text(departure)
            separatorLine
            Text("\(travelTime, specifier: "%.0f") часов")
                .font(.system(size: 12, weight: .regular))
            separatorLine
            Text(arrival)
        }
        .foregroundStyle(.ypBlackUniversal)
    }
    
    private var separatorLine: some View {
        Rectangle()
            .foregroundStyle(.ypGray)
            .frame(height: 1)
    }
}

#Preview {
    CarriersView()
        .environmentObject(NavigationRouter())
        .environmentObject(ScheduleViewModel.mock)
}
