//
//  StoriesProgressBar.swift
//  TravelSchedule
//
//  Created by Anastasiia on 20.04.2025.
//

import SwiftUI
import Combine

struct StoriesProgressBar: View {
    let storiesCount: Int
    let timerConfiguration: TimerConfiguration
    @Binding var currentProgress: CGFloat
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    
    init(
        storiesCount: Int,
        timerConfiguration: TimerConfiguration,
        currentProgress: Binding<CGFloat>
    ) {
        self.storiesCount = storiesCount
        self.timerConfiguration = timerConfiguration
        self._currentProgress = currentProgress
        self.timer = Self.makeTimer(configuration: timerConfiguration)
    }
    
    var body: some View {
        ProgressBar(numberOfSections: storiesCount, progress: currentProgress)
            .padding(.init(top: 7, leading: 12, bottom: 12, trailing: 12))
            .onAppear {
                timer = Self.makeTimer(configuration: timerConfiguration)
                cancellable = timer.connect()
            }
            .onDisappear {
                cancellable?.cancel()
            }
            .onReceive(timer) { _ in
                timerTick()
            }
    }
    
    private func timerTick() {
        withAnimation {
            currentProgress = timerConfiguration.nextProgress(progress: currentProgress)
        }
    }
}

extension StoriesProgressBar {
    private static func makeTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerTickInternal, on: .main, in: .common)
    }
}

#Preview {
    StoriesProgressBar(
        storiesCount: 5,
        timerConfiguration: TimerConfiguration(storiesCount: 5),
        currentProgress: Binding.constant(0)
    )
}
