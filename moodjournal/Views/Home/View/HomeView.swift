//
//  HomeView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDay = Self.now
    private static var now = Date()

    var body: some View {
        VStack {
            WeekView(calendar: Calendar(identifier: .gregorian), selectedDay: $selectedDay)
            MoodCarousel()
            Spacer()
                            
        }
    }
}

#Preview {
    HomeView()
}
