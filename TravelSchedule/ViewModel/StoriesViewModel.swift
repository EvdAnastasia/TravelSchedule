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
    
    func showStory(at id: UUID) {
        if let firstStory = stories.first(where: { $0.id == id }) {
            var finalStories: [Story] = [firstStory]
            let remainingStories = stories.filter{ $0.id != id }.sorted { (story1: Story, story2: Story) in
                if !story1.isViewed && story2.isViewed {
                    return true
                } else if story1.isViewed && !story2.isViewed {
                    return false
                } else {
                    return story1.imageName < story2.imageName
                }
            }
            
            finalStories.append(contentsOf: remainingStories)
            stories = finalStories
            currentStoryIndex = 0
            currentProgress = 0
        }
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
    
    func orderStories() {
        let viewedStories = stories.filter{ $0.isViewed == true }.sorted(by: { $0.imageName < $1.imageName })
        let notViewedStories = stories.filter{ $0.isViewed == false }.sorted(by: { $0.imageName < $1.imageName })
        stories = notViewedStories + viewedStories
    }
    
    func setStoryAsViewed(to index: Int) {
        if stories.indices.contains(index) {
            stories[index].isViewed = true
        }
    }
}
