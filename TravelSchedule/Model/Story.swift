//
//  Story.swift
//  TravelSchedule
//
//  Created by Anastasiia on 19.04.2025.
//

import Foundation

struct Story: Identifiable {
    let id: UUID
    let imageName: String
    let title: String
    let description: String
    var isViewed: Bool
}
