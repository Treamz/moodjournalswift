//
//  MoodItem.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import Foundation

struct MoodItem : Codable, Identifiable, Hashable{
    let id: String
    let title: String
    let date : TimeInterval
}
