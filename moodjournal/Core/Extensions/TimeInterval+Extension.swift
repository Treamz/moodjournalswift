//
//  TimeInterval+Extension.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 02.06.2024.
//

import Foundation

extension TimeInterval {
    // Builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
        let totalMilliseconds = self * 1000
        let milliseconds = Int(totalMilliseconds) % 1000 / 100 // Gets only the first digit of the milliseconds
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }
}
