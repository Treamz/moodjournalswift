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
//    @StateObject var viewModel = AppViewModel()

    let persistenceController = PersistenceController.shared
    @StateObject var networkMonitor = NetworkMonitor()
    init() {
        if !isPreview {
            FirebaseApp.configure()
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(networkMonitor)
        }
    }
}


extension App {
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
}
