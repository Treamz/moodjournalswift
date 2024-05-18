//
//  WeekView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI

struct WeekView: View {
    private let calendar: Calendar
    private let monthDayFormatter: DateFormatter
    private let dayFormatter: DateFormatter
    private let weekDayFormatter: DateFormatter
    
    @Binding var selectedDay: Date
    
    
    init(calendar: Calendar,selectedDay: Binding<Date>) {
        self.calendar = calendar
        self.monthDayFormatter = DateFormatter(dateFormat: "MM/dd",calendar: calendar)
        self.dayFormatter = DateFormatter(dateFormat: "d",calendar: calendar)
        self.weekDayFormatter = DateFormatter(dateFormat: "EEEEE",calendar: calendar)
        self._selectedDay = selectedDay

    }
    var body: some View {
        CalendarWeekListView(
                            calendar: calendar,
                            date: $selectedDay,
                            content: { date in
                                Button(action: {
                                    selectedDay = date
                                    
                                }) {
                                    VStack(spacing: 10) {
                                        Text(dayFormatter.string(from: date))
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                        
                                        Text(weekDayFormatter.string(from: date))
                                            .font(.system(size: 14))
                                        
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 8, height: 8)
                                            .opacity(calendar.isDate(date, inSameDayAs: selectedDay) ? 1 : 0)
                                        
                                    }
                                    .foregroundStyle(calendar.isDate(date, inSameDayAs: selectedDay) ? .primary : .secondary)
                                    .foregroundColor(calendar.isDate(date, inSameDayAs: selectedDay) ? .white : .black)
                                    .frame(width: 45, height: 90)
                                    .background(
                                        ZStack {
                                            if calendar.isDate(date, inSameDayAs: selectedDay) {
                                                Capsule()
                                                    .fill(Color.black)
                                            }
                                        }
                                    )
                                }
                            },
                            header: { date in
//                                    Text(weekDayFormatter.string(from: date))
//                                        .frame(maxWidth: .infinity)
                            },
                            title: { date in
                                HStack {
                                    Text(monthDayFormatter.string(from: selectedDay))
                                        .font(.headline)
                                        .padding(5)
                                    Spacer()
                                }
                                .padding([.bottom, .leading], 10)
                            },
                            weekSwitcher: { date in
                                Button {
                                    withAnimation(.easeIn) {
                                        guard let newDate = calendar.date(
                                            byAdding: .weekOfMonth,
                                            value: -1,
                                            to: selectedDay
                                        ) else {
                                            return
                                        }
                                        
                                        selectedDay = newDate
                                    }
                                } label: {
                                    Label(
                                        title: { Text("Previous") },
                                        icon: { Image(systemName: "chevron.left") }
                                    )
                                        .labelStyle(IconOnlyLabelStyle())
                                        .padding(.horizontal)
                                }
                                Button {
                                    withAnimation(.easeIn) {
                                        guard let newDate = calendar.date(
                                            byAdding: .weekOfMonth,
                                            value: 1,
                                            to: selectedDay
                                        ) else {
                                            return
                                        }
                                        
                                        selectedDay = newDate
                                    }
                                } label: {
                                    Label(
                                        title: { Text("Next") },
                                        icon: { Image(systemName: "chevron.right") }
                                    )
                                        .labelStyle(IconOnlyLabelStyle())
                                        .padding(.horizontal)
                                }
                            }
                        )
    }
}

private extension DateFormatter {
    convenience init(dateFormat: String,calendar: Calendar) {
        self.init()
        self.dateFormat = dateFormat
        self.calendar = calendar
        self.locale = Locale(identifier: "EN_en")
    }
}


#Preview {
    WeekView(calendar: Calendar(identifier:.gregorian),selectedDay: .constant(.now))
}
