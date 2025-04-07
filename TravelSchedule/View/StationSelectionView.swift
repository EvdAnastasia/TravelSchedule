//
//  StationSelectionView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 07.04.2025.
//

import SwiftUI

struct StationSelectionView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @EnvironmentObject var routerManager: NavigationRouter
    @State private var searchString: String = ""
    private var direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var searchResults: [Stations] {
        viewModel.stations.filter {
            searchString.isEmpty || ($0.title?.contains(searchString.capitalized) ?? false)
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack {
                SearchBar(searchText: $searchString)
                
                if !searchResults.isEmpty {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(searchResults, id: \.self) { station in
                                ListRowView(text: station.title ?? "")
                                    .onTapGesture {
                                        viewModel.setStation(for: direction, station: station)
                                        routerManager.reset()
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
                    NotFoundView(text: "Станция не найдена")
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
            }
        }
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundStyle(.ypBlack)
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    StationSelectionView(direction: .from)
}
