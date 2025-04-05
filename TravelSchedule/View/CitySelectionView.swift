//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 04.04.2025.
//

import SwiftUI

struct CitySelectionView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @State private var searchString: String = ""
    
    var searchResults: [SettlementsFromStationsList] {
        viewModel.settlements.filter {
            searchString.isEmpty || ($0.title?.contains(searchString.capitalized) ?? false)
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(searchResults, id: \.self) { settlement in
                        ListRowView(settlement: settlement.title ?? "")
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(.ypBlack)
    }
}

#Preview {
    CitySelectionView()
}
