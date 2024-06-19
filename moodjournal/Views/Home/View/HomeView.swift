//
//  HomeView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI
import ConfettiSwiftUI


struct HomeView: View {
    @State private var selectedDay = Self.now
    private static var now = Date()
    @State private var startShower = false
    @State private var counter: Int = 0
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var isPresentedCamera = false

    var body: some View {
        VStack {
            WeekView(calendar: Calendar(identifier: .gregorian), selectedDay: $selectedDay)
    
            MoodsRow(moods: viewModel.moods)
            Spacer()
                            
        }
        .overlay( alignment: .bottom) {
            if isToday(date: selectedDay) {
                ZStack(alignment: .bottom) {
                    SnapCarousel(onDataChange: { newData in
                        counter += 1
                        print("newData \(newData)")
                        if(newData == "camera") {
                            isPresentedCamera.toggle()
                        } else {
                            Task {
                                try await viewModel.addMood(forDate: isToday(date: selectedDay) ? .now : selectedDay, mood: newData)
                            }
                        }
                       
                    })
                }
                .frame(height: 200)
            }
        }
        .fullScreenCover(isPresented: $isPresentedCamera) {
            EmoteCameraView()
        }
        .onAppear {
            Task {
                await viewModel.getMoodByDate(byDate: selectedDay)
            }
        }
        .onChange(of: selectedDay) {
            print(selectedDay)
            Task {
                await viewModel.getMoodByDate(byDate: selectedDay)
            }
        }
        .environmentObject(viewModel)
    }
    
    
    func isToday(date: Date) -> Bool {
            let calendar = Calendar.current
            return calendar.isDateInToday(date)
        }
}

#Preview {
    HomeView()
}
