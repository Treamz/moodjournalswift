//
//  DayItem.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import SwiftUI

struct DayItem: View {
    var moods: [MoodItem]
    var color: Color
    var day: Date
    var body: some View {
        VStack {
            HStack(spacing: -30)  {
                if !todayMoods.isEmpty {
                    ForEach(todayMoods) { mood in
                        Text(mood.title)
                        
                    }
                }else {
                    Text("+")
                }
            }
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,minHeight: 40)
                .background(Circle().foregroundStyle(Date.now.startOfDay == day.startOfDay ? .red.opacity(0.3) : color.opacity(0.3)))
            Text(day.formatted(.dateTime.day()))

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
    DayItem(moods: [],color: .orange, day: .now)
}
