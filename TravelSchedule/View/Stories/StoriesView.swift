//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 20.04.2025.
//

import SwiftUI
import Combine

struct StoriesView: View {
    @ObservedObject private var storiesViewModel: StoriesViewModel
    @Environment(\.dismiss) var dismiss
    
    init(model: StoriesViewModel) {
        storiesViewModel = model
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoriesTabView(
                stories: storiesViewModel.stories,
                currentStoryIndex: $storiesViewModel.currentStoryIndex
            )
            .onChange(of: storiesViewModel.currentStoryIndex) { newValue in
                storiesViewModel.didChangeCurrentIndex(to: newValue)
            }
            
            StoriesProgressBar(
                storiesCount: storiesViewModel.stories.count,
                timerConfiguration: storiesViewModel.timerConfiguration,
                currentProgress: $storiesViewModel.currentProgress
            )
            .padding(.init(top: 28, leading: 4, bottom: 12, trailing: 4))
            .onChange(of: storiesViewModel.currentProgress) { newValue in
                storiesViewModel.didChangeCurrentProgress(to: newValue)
            }
            
            CloseButton {
                closeStories()
            }
            .padding(.trailing, 12)
            .padding(.top, 57)
        }
    }
    
    private func closeStories() {
        dismiss()
    }
}

#Preview {
    StoriesView(model: StoriesViewModel())
}
