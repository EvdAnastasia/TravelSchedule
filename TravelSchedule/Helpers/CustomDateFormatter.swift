//
//  CustomDateFormatter.swift
//  TravelSchedule
//
//  Created by Anastasiia on 14.04.2025.
//

import Foundation

struct CustomDateFormatter {
    static let dateParser: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
