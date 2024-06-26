//
//  CalendarView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI

struct CalendarView: View {
    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)

    @StateObject private var vm: CalendarViewModel = CalendarViewModel()
    @State private var color: Color = .orange
    @State private var date = Date.now
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()) , count: 7)
    @State private var days: [Date] = []
    var body: some View {
        NavigationView {
            VStack {
    //            LabeledContent("Calendar Color") {
    //                ColorPicker("", selection: $color,supportsOpacity: false)
    //            }
    //            LabeledContent("Date / Time") {
    //                DatePicker("", selection: $date)
    //            }
                HStack {
                    ForEach(daysOfWeek.indices,id: \.self) { index in
                        Text(daysOfWeek[index])
                            .fontWeight(.bold)
                            .foregroundStyle(color)
                            .frame(maxWidth: .infinity)
                        
                    }
                }
                LazyVGrid(columns: columns){
                    ForEach(days,id: \.self) { day in
                        if (day.monthInt != date.monthInt) {
                            Text("")
                        }
                        else {
                            NavigationLink(destination: DayView(moods: vm.moods, day: day)) {
                                DayItem(moods: vm.moods, color: color, day: day)
                            }
                            .onTapGesture {
                                impactFeedback.impactOccurred()
                            }
                        }
                         
                    }
                }
                Spacer()
            }
            .padding()
            .onAppear {
                days = date.calendarDisplayDays
                vm.fetchMoods()
            }
            .onChange(of: date) { days = date.calendarDisplayDays
        }
        }
    }
}
#Preview {
    CalendarView()
}
