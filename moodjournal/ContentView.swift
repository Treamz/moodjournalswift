//
//  ContentView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.05.2024.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @StateObject var viewModel = AppViewModel()

    var body: some View {
        Group {
            if (viewModel.userSession == nil) {
               Text("Not Loaded")
                    .onAppear {
                        Task {
                            try await viewModel.signIn()
                        }
                    }
            }
            else {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Me", systemImage: "person.circle")
                        }
                   
                    CalendarView()
                        .tabItem {
                            Label("Calendar", systemImage: "calendar.circle")
                            
                        }
                    ChatView()
                        .tabItem {
                            Label("Chat", systemImage: "message.circle")
                            
                        }
                    SettingsView()
                        .tabItem {
                            Label("Settings", systemImage: "gear")
                            
                        }
                }
                .tint(.orange)
               
            }
        }
        


    }
}

#Preview {
    ContentView()
}
