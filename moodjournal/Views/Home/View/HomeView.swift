//
//  HomeView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI
import ConfettiSwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase

struct HomeView: View {
    @State private var selectedDay = Self.now
    private static var now = Date()
    @State private var startShower = false
    @State private var counter: Int = 0
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
  
    var body: some View {
        VStack {
            WeekView(calendar: Calendar(identifier: .gregorian), selectedDay: $selectedDay)
    
            MoodsRow(moods: viewModel.moods)
            Spacer()
                            
        }
        .overlay( alignment: .bottom) {
            ZStack(alignment: .bottom) {
                SnapCarousel(onDataChange: { newData in
                    counter += 1
                    print("newData \(newData)")
                    Task {
                    
                        try await viewModel.addMood(forDate: isToday(date: selectedDay) ? .now : selectedDay, mood: newData)
                    }
                })
            }
            .frame(height: 200)
        }
        .confettiCannon(counter: $counter,confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")],confettiSize: 40,openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
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
