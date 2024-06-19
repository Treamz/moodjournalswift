//
//  moodjournalApp.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.05.2024.
//

import SwiftUI
import FirebaseCore
@main
struct moodjournalApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var networkMonitor = NetworkMonitor()
    
    @StateObject var authManager: AuthManager

    init() {
    
        FirebaseApp.configure()
        let authManager = AuthManager()
        _authManager = StateObject(wrappedValue: authManager)
        //isOnboarding = true
    }
    var body: some Scene {
        WindowGroup {
            AppView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(networkMonitor)
                .environmentObject(authManager)
        }
    }
}


extension App {
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
