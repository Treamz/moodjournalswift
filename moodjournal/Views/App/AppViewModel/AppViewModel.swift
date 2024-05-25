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
    
    func signInWithApple() async throws {
        do {
            if(userSession!.isAnonymous) {
                // User is anonymous
               // let credential = AppleAuthPr.credential(withIDToken: idToken,
//                                                               accessToken: authentication.accessToken)
//                authLink(credentials: AuthCredential.)
            }

        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")

        }
    }
    
    private func authLink(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            guard let user = Auth.auth().currentUser else { return nil }
            let result = try await user.link(with: credentials)
            // TODO: Update user's displayName
            self.userSession = result.user
            return result
        }
        catch {
            print("FirebaseAuthError: link(with:) failed, \(error)")
            throw error
        }
    }
}
