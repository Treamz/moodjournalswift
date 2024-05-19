//
//  User.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return "";
    }
}

extension User {
    static var MOCK_USER = User(id: UUID().uuidString, fullName: "Ivan Chernoknizhnikov", email: "test@gmail.com")
}
