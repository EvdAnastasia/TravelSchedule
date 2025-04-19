//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Anastasiia on 19.04.2025.
//

import Foundation

final class StoriesViewModel: ObservableObject {
    @Published var stories = MockStories.data
}
