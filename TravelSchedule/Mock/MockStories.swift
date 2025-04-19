//
//  MockStories.swift
//  TravelSchedule
//
//  Created by Anastasiia on 19.04.2025.
//

import Foundation

struct MockStories {
    
    static let data: [Story] = {
        var stories: [Story] = []
        for i in 1...5 {
            let story = Story(
                id: UUID(),
                imageName: "Story\(i)",
                title: "Text Text Text Text Text Text Text Text Text Text",
                description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
                isViewed: false
            )
            stories.append(story)
        }
        
        return stories
    }()
    
    private init() {}
}
