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
            MoodCarousel(onDataChange: { newData in
                counter += 1
                Task {
                    try await viewModel.addMood(forDate: Self.now, mood: newData)
                }
            })
    
            MoodsRow(moods: viewModel.moods)
            Spacer()
                            
        }
        .confettiCannon(counter: $counter,confettis: [.text("❤️"), .text("💙"), .text("💚"), .text("🧡")],confettiSize: 40,openingAngle: Angle(degrees: 0), closingAngle: Angle(degrees: 360), radius: 200)
        .onAppear {
            Task {
                await viewModel.getMoodByDate()
            }
        }
    }
    
}

#Preview {
    HomeView()
}
