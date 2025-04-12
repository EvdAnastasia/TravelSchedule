//
//  GenericErrorView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 31.03.2025.
//

import SwiftUI

struct GenericErrorView: View {
    let imageName: String
    let text: String
    
    init(type error: ErrorType) {
        switch error {
        case .internetConnectionError:
            self.imageName = "InternetError"
            self.text = "Нет интернета"
        case .serverError:
            self.imageName = "ServerError"
            self.text = "Ошибка сервера"
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 16) {
                Image(imageName)
                Text(text)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.ypBlack)
            }
        }
    }
}

#Preview {
    GenericErrorView(type: .serverError)
}
