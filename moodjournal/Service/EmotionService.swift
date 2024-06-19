//
//  EmotionService.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.06.2024.
//

import Foundation


class EmotionService {
    static func getEmojisByText(text: String) -> [Mood] {
        return moods.filter { mood in
            return mood.name.contains(text)
        }
    }
}
