//
//  Route.swift
//  TravelSchedule
//
//  Created by Anastasiia on 02.04.2025.
//

import SwiftUI

enum Route: Hashable {
    case userAgreement
}

extension Route: View {
    var body: some View {
        switch self {
        case .userAgreement:
            UserAgreementView()
        }
    }
}
