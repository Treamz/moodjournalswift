//
//  StartButtonView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 25.05.2024.
//

import SwiftUI
import AuthenticationServices
import GoogleSignInSwift
struct StartButtonView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject var authManager: AuthManager
    
    // MARK: - BODY
    
    var body: some View {
        
        Button(action: {
          isOnboarding = false
        }) {
          HStack(spacing: 8) {
            Text("Start")
            
            Image(systemName: "arrow.right.circle")
              .imageScale(.large)
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 10)
          .background(
            Capsule().strokeBorder(Color.white, lineWidth: 1.25)
          )
        } //: BUTTON
        .accentColor(Color.white)
        .onAppear {
            NotificationService.shared.requestNotification { result in
                switch result {
                case .success(_):
                    NotificationService.shared.scheduleNotification()
                case .failure(_):
                    return
                    //
                }
            }
        }
        
    }
    
    func handleAppleID(_ result: Result<ASAuthorization, Error>) {
           if case let .success(auth) = result {
               guard let appleIDCredentials = auth.credential as? ASAuthorizationAppleIDCredential else {
                   print("AppleAuthorization failed: AppleID credential not available")
                   return
               }

               Task {
                   do {
                       let result = try await authManager.appleAuth(
                           appleIDCredentials,
                           nonce: AppleSignInManager.nonce
                       )
                       if result != nil {
                           isOnboarding = false
                       }
                   } catch {
                       print("AppleAuthorization failed: \(error)")
                       // Here you can show error message to user.
                   }
               }
           }
           else if case let .failure(error) = result {
               print("AppleAuthorization failed: \(error)")
               // Here you can show error message to user.
           }
       }

}
#Preview {
    StartButtonView()
        .environmentObject(AuthManager())
}
