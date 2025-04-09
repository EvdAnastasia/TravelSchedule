//
//  CarrierCardView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 09.04.2025.
//

import SwiftUI

struct CarrierCardView: View {
    
    private let segment: Segments
    private let startDate: String
    private let departure: String
    private let arrival: String
    private let travelTime: Double
    
    init(segmentInfo: Segments, startDate: String, departure: String, arrival: String) {
        self.segment = segmentInfo
        self.startDate = startDate
        self.departure = departure
        self.arrival = arrival
        travelTime = (segment.duration ?? 0)/3600
    }
    
    var body: some View {
        ZStack {
            Color.ypLightGrayUniversal
            
            VStack(spacing: 14) {
                HStack(alignment: .center, spacing: 18) {
                    AsyncImage(url: URL(string: segment.thread?.carrier?.logo ?? "")) { loading in
                        switch loading {
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
                    Spacer()
                    Text(startDate)
                        .font(.system(size: 12, weight: .regular))
                }
                .foregroundStyle(.ypBlackUniversal)
                
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
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
    }
    
    @ViewBuilder
    var separatorLine: some View {
        Rectangle()
            .foregroundStyle(.ypGray)
            .frame(height: 1)
    }
}

#Preview {
    CarrierCardView(segmentInfo: Segments(), startDate: "", departure: "", arrival: "")
}
