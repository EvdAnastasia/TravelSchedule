//
//  NavigationRouter.swift
//  TravelSchedule
//
//  Created by Anastasiia on 02.04.2025.
//

import Foundation

final class NavigationRouter: ObservableObject {
    @Published var routes = [Route]()
    
    func push(to screen: Route) {
        print(screen)
        routes.append(screen)
    }
    
    func reset() {
        routes = []
    }
    
    func navigateBack() {
        _ = routes.popLast()
    }
}
