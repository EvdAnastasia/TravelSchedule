//
//  CitySelectionView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 04.04.2025.
//

import SwiftUI

struct CitySelectionView: View {
    @EnvironmentObject private var scheduleViewModel: ScheduleViewModel
    @EnvironmentObject private var routerManager: NavigationRouter
    @State private var searchString: String = ""
    
    private var direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var searchResults: [SettlementsFromStationsList] {
        scheduleViewModel.settlements.filter {
            searchString.isEmpty || ($0.title?.contains(searchString.capitalized) ?? false)
        }
    }
    
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
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(.ypBlack)
    }
    
    // MARK: - Content
    
    private var content: some View {
        VStack {
            SearchBar(searchText: $searchString)
            if !searchResults.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading) {
                        ForEach(searchResults, id: \.self) { settlement in
                            ListRowView(text: settlement.title ?? "")
                                .onTapGesture {
                                    scheduleViewModel.setSettlement(for: direction, settlement: settlement)
                                    scheduleViewModel.getStations(for: settlement)
                                    routerManager.push(to: .stationSelection(direction: direction))
                                }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .onTapGesture {
                    hideKeyboard()
                }
                .scrollIndicators(.hidden)
            } else {
                Spacer()
                NotFoundView(text: "Город не найден")
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
            
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    CitySelectionView(direction: .from)
        .environmentObject(ScheduleViewModel())
}
