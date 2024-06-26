//
//  ContentView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.05.2024.
//

import SwiftUI
import FirebaseAuth
struct AppView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    @StateObject var viewModel = AppViewModel()
    
    @AppStorage("systemThemeVal") private var systemTheme: Int = SchemeType.allCases.first!.rawValue

    @Environment(\.colorScheme) private var colorScheme;
    
    var selectedScheme: ColorScheme? {
           guard let theme = SchemeType(rawValue: systemTheme) else { return nil }
           switch theme {
           case .light:
               return .light
           case .dark:
               return .dark
           default:
               return nil
               
           }
       }
    
    @EnvironmentObject var authManager: AuthManager


    var body: some View {
        Group {
            if isOnboarding {
                OnBoardingView()
            } else {
                Group {
                    if (authManager.authState == .signedOut) {
                        LoginView()
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
                        .tint(Color("Tint"))
                       
                    }
                }
            }
        }
        .background(Color("Background"))
        .preferredColorScheme(selectedScheme)
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        


    }
}

#Preview {
    AppView()
}
