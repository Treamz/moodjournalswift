//
//  ContentView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.05.2024.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Me", systemImage: "person.circle")
                }
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar.circle")
                    
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                    
                }
        }
        .tint(.orange)


    }
}

#Preview {
    ContentView()
}
