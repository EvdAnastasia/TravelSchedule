//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Anastasiia on 19.04.2025.
//

import SwiftUI

final class StoriesViewModel: ObservableObject {
    @Published var stories = MockStories.data
    @Published var currentStoryIndex: Int = 0
    @Published var currentProgress: CGFloat = 0
    @Published var timerConfiguration: TimerConfiguration
    
    init() {
        timerConfiguration = TimerConfiguration(storiesCount: MockStories.data.count)
    }
    
    func didChangeCurrentIndex(to index: Int) {
        let progress = timerConfiguration.progress(for: index)
        guard abs(progress - currentProgress) >= 0.01 else { return }
        withAnimation {
            currentProgress = progress
        }
    }
    
    func didChangeCurrentProgress(to progress: CGFloat) {
        let index = timerConfiguration.index(for: progress)
        guard index != currentStoryIndex else { return }
        withAnimation {
            currentStoryIndex = index
        }
    }
}
