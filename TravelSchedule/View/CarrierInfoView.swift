//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.04.2025.
//

import SwiftUI

struct CarrierInfoView: View {
    @EnvironmentObject private var scheduleViewModel: ScheduleViewModel
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: carriersViewModel.carrier?.logo ?? "")) { loading in
                    switch loading {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    default:
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundStyle(.ypBlackUniversal)
                    }
                }
                .frame(width: 343, height: 104)
                .background(.ypWhiteUniversal)
                .clipShape(.rect(cornerRadius: 24))
                
                VStack(alignment: .leading, spacing: 16) {
                    Text(carriersViewModel.carrier?.title ?? "Нет информации")
                        .font(.system(size: 24, weight: .bold))
                    VStack(alignment: .leading, spacing: 0) {
                        Text("E-mail")
                            .font(.system(size: 17, weight: .regular))
                        Text(carriersViewModel.carrier?.email ?? "Нет информации")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypBlue)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Телефон")
                            .font(.system(size: 17, weight: .regular))
                        Text(carriersViewModel.carrier?.phone ?? "Нет информации")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(.ypBlue)
                    }
                }
                Spacer()
                    .navigationTitle("Информация о перевозчике")
            }
            .foregroundStyle(.ypBlack)
            .padding(16)
        }
    }
}

#Preview {
    CarrierInfoView()
        .environmentObject(ScheduleViewModel())
}
