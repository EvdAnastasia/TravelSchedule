//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Anastasiia on 20.04.2025.
//

import SwiftUI
import Combine

struct StoriesView: View {
    
    // MARK: - Properties
    
    @ObservedObject private var storiesViewModel: StoriesViewModel
    @Environment(\.dismiss) var dismiss
    
    @GestureState private var dragOffset: CGSize = .zero
    
    // MARK: - Init
    
    init(model: StoriesViewModel) {
        self.storiesViewModel = model
    }
    
    // MARK: - Content
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            tabView
            progressBar
            closeButton
        }
        .offset(y: dragOffset.height > 0 ? dragOffset.height : 0)
        .gesture(dragGesture)
        .animation(.easeOut, value: dragOffset)
        .onAppear {
            storiesViewModel.setStoryAsViewed(to: storiesViewModel.currentStoryIndex)
        }
    }
    
    // MARK: - Views
    
    private var tabView: some View {
        StoriesTabView(
            stories: storiesViewModel.stories,
            currentStoryIndex: $storiesViewModel.currentStoryIndex
        )
        .onChange(of: storiesViewModel.currentStoryIndex) { newValue in
            storiesViewModel.setStoryAsViewed(to: newValue)
            storiesViewModel.didChangeCurrentIndex(to: newValue)
        }
    }
    
    private var progressBar: some View {
        StoriesProgressBar(
            storiesCount: storiesViewModel.stories.count,
            timerConfiguration: storiesViewModel.timerConfiguration,
            currentProgress: $storiesViewModel.currentProgress
        )
        .padding(.init(top: 28, leading: 4, bottom: 12, trailing: 4))
        .onChange(of: storiesViewModel.currentProgress) { newValue in
            storiesViewModel.didChangeCurrentProgress(to: newValue)
        }
    }
    
    private var closeButton: some View {
        CloseButton {
            closeStories()
        }
        .padding(.trailing, 12)
        .padding(.top, 57)
    }
    
    // MARK: - Gesture
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                state = value.translation
            }
            .onEnded { value in
                if value.translation.height > 100 {
                    closeStories()
                }
            }
    }
    
    // MARK: - Actions
    
    private func closeStories() {
        dismiss()
        storiesViewModel.orderStories()
    }
}

// MARK: - StoriesView_Preview

#Preview {
    StoriesView(model: StoriesViewModel())
}
