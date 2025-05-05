//
//  CarrierInfoView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 11.04.2025.
//

import SwiftUI

// MARK: - CarrierInfoView

struct CarrierInfoView: View {
    
    // MARK: - Environment
    
    @EnvironmentObject private var scheduleViewModel: ScheduleViewModel
    @EnvironmentObject private var carriersViewModel: CarriersViewModel
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            content
        }
        .navigationTitle("Информация о перевозчике")
    }
    
    // MARK: - Content
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 16) {
            logoView
            infoView
            Spacer()
        }
        .foregroundStyle(.ypBlack)
        .padding(16)
    }
    
    // MARK: - Views
    
    private var logoView: some View {
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
    }
    
    private var infoView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(carriersViewModel.carrier?.title ?? "Нет информации")
                .font(.system(size: 24, weight: .bold))
            emailSection
            phoneSection
        }
    }
    
    private var emailSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("E-mail")
                .font(.system(size: 17, weight: .regular))
            Text(carriersViewModel.carrier?.email ?? "Нет информации")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.ypBlue)
        }
    }
    
    private var phoneSection: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Телефон")
                .font(.system(size: 17, weight: .regular))
            Text(carriersViewModel.carrier?.phone ?? "Нет информации")
                .font(.system(size: 12, weight: .regular))
                .foregroundStyle(.ypBlue)
        }
    }
}

// MARK: - CarrierInfoView_Preview

#Preview {
    CarrierInfoView()
        .environmentObject(ScheduleViewModel())
        .environmentObject(CarriersViewModel())
}
