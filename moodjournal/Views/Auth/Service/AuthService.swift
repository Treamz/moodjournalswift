//
//  AuthService.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 13.06.2024.
//

import Foundation
import Firebase

class AuthService {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentSession: User?
    
    static let shared = AuthService()
    
    
    init() {
        
    }
}
