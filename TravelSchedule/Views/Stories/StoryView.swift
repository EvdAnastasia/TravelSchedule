//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 20.04.2025.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    
    var body: some View {
        ZStack {
            Color.ypBlackUniversal.ignoresSafeArea()
            
            Image(story.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 40))
            
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    Spacer()
                    Text(story.title)
                        .font(.system(size: 34, weight: .bold))
                        .lineLimit(2)
                    Text(story.description)
                        .font(.system(size: 20, weight: .regular))
                        .lineLimit(3)
                }
                .foregroundStyle(.ypWhiteUniversal)
                .padding(.bottom, 40)
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    StoryView(story: StoriesMock.data[0])
}
