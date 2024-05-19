//
//  AppViewModel.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import Foundation
import FirebaseCore
import Firebase
import FirebaseFirestore
import FirebaseAuth

@MainActor
class AppViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?


    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn() async throws {
        do {
            let result = try await Auth.auth().signInAnonymously()
            self.userSession = result.user

        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")

        }
    }
}
