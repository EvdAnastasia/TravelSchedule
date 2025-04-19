//
//  StoryPreview.swift
//  TravelSchedule
//
//  Created by Anastasiia on 19.04.2025.
//

import SwiftUI

struct StoryPreview: View {
    let story: Story
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.imageName + "-preview")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text(story.title)
                .lineLimit(3)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypWhiteUniversal)
                .padding(.horizontal, 8)
                .padding(.bottom, 12)
        }
        .frame(width: 92, height: 140)
        .overlay {
            RoundedRectangle(cornerRadius: 16).strokeBorder(Color.ypBlue, lineWidth: story.isViewed ? 0 : 4)
        }
        .cornerRadius(16)
        .opacity(story.isViewed ? 0.5 : 1)
        .padding(.vertical, 24)
    }
}

#Preview {
    StoryPreview(story: MockStories.data[0])
}
