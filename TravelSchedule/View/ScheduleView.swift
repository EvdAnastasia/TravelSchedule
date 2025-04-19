//
//  ScheduleView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 31.03.2025.
//

import SwiftUI

struct ScheduleView: View {
    @EnvironmentObject var routerManager: NavigationRouter
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @StateObject private var storiesViewModel = StoriesViewModel()
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(spacing: 16) {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 12) {
                        ForEach(storiesViewModel.stories) { story in
                            StoryPreview(story: story)
                                .onTapGesture {
                                }
                        }
                    }
                }
                .padding(.leading, 16)
                .scrollIndicators(.hidden)
                .frame(height: 188)
                
                ZStack {
                    Color.ypBlue
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 0) {
                            ChoosingDirectionView(
                                path: viewModel.directionFrom,
                                placeholder: "Откуда"
                            )
                            .onTapGesture {
                                routerManager.push(to: .citySelection(direction: .from))
                            }
                            ChoosingDirectionView(
                                path: viewModel.directionTo,
                                placeholder: "Куда"
                            )
                            .onTapGesture {
                                routerManager.push(to: .citySelection(direction: .to))
                            }
                        }
                        .font(.system(size: 17, weight: .regular))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.ypWhiteUniversal)
                        )
                        
                        Button {
                            viewModel.changeDirection()
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
                    Task {
                        await viewModel.search()
                    }
                    routerManager.push(to: .carriers)
                } label: {
                    Text("Найти")
                        .frame(width: 150, height: 60)
                        .font(.system(size: 17, weight: .bold))
                        .background(.ypBlue)
                        .foregroundStyle(.ypWhiteUniversal)
                        .cornerRadius(16)
                }
                .opacity(viewModel.isSearchButtonEnabled ? 1 : 0)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ScheduleView()
        .environmentObject(ScheduleViewModel())
        .environmentObject(StoriesViewModel())
}
