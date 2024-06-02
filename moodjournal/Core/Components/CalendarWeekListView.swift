//
//  CalendarWeekListView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.05.2024.
//

import SwiftUI

struct CalendarWeekListView<Day: View, Header:View,Title:View, WeekSwitcher:View>: View {
    private var calendar: Calendar
    @Binding private var date: Date
    private let content: (Date) -> Day
    private let header: (Date) -> Header
    private let title: (Date) -> Title
    private let weekSwitcher: (Date) -> WeekSwitcher
    
    private let daysInWeek = 7

    init(
        calendar: Calendar,
        date: Binding<Date>,
        @ViewBuilder content: @escaping (Date) -> Day,
        @ViewBuilder header: @escaping (Date) -> Header,
        @ViewBuilder title: @escaping (Date) -> Title,
        @ViewBuilder weekSwitcher: @escaping (Date) -> WeekSwitcher
    ) {
        self.calendar = calendar
        self._date = date
        self.content = content
        self.header = header
        self.title = title
        self.weekSwitcher = weekSwitcher
    }

    var body: some View {
        let days  = makeDays()
        let month = date.starOfMonth(using: calendar)
        VStack {
            HStack {
                self.title(month)
                self.weekSwitcher(month)
            }
            HStack(spacing : 30) {
                ForEach(days.prefix(daysInWeek),id: \.self,content: header)
            }
            .padding(.horizontal, 20)
            HStack {
                ForEach(days,id: \.self ) { date in
                        content(date)
                }
            }
        }
        .frame(maxWidth: .infinity,alignment: .top)
    }
}
// MARK: - Helper

private extension Date {
    func starOfMonth(using calendar: Calendar) -> Date {
        calendar.date(from: calendar.dateComponents( [.year,.month], from: self)) ?? self
    }

}

private extension CalendarWeekListView {
    func makeDays() -> [Date] {
        guard let firstWeek = calendar.dateInterval(of: .weekOfYear, for: date),
              let lastWeek =  calendar.dateInterval(of: .weekOfYear, for: firstWeek.end - 1) else {
            return []
        }
        let dateInterval = DateInterval(start: firstWeek.start, end: lastWeek.end)
        return calendar.generateDays(for: dateInterval)
                
    }
}

private extension Calendar {
    func generateDates(for dateInterval: DateInterval,
                       matching components: DateComponents) -> [Date] {
        var dates = [dateInterval.start]
        enumerateDates(startingAfter: dateInterval.start, matching: components, matchingPolicy: .nextTime) {
            date, _, stop in
            guard let date = date else {return}
            guard date < dateInterval.end else {
                stop = true
                return
            }
            dates.append(date)
            
        }
        return dates
    }
    
    func generateDays(for dateInterval: DateInterval) -> [Date] {
        generateDates(for: dateInterval, matching: dateComponents([.hour,.minute,.second] ,from: dateInterval.start))
    }
}
#Preview {
    WeekView(calendar: Calendar(identifier: .gregorian),selectedDay: .constant(.now))
}
