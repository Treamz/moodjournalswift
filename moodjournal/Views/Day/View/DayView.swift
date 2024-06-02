//
//  DayView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 01.06.2024.
//

import SwiftUI

struct DayView: View {
    var moods: [MoodItem]
    var day: Date

    var body: some View {
        ScrollView {
            VStack {
                ForEach(todayMoods) { mood in
                    Text(mood.title)
                }
            }
        }
    }
    
    var todayMoods: [MoodItem] {
            let startOfDay = day.startOfDay.timeIntervalSince1970
            let endOfDay = day.endOfDay.timeIntervalSince1970
            let filteredMoods = moods.filter { $0.date >= startOfDay && $0.date <= endOfDay }

            return Array(filteredMoods.prefix(3))
        }
}

#Preview {
    DayView(moods: [],day: .now)
}
