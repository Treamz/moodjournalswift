//
//  EmojiItem.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import SwiftUI

struct EmojiItem: View {
    var emoji: String
    var body: some View {
        Text(emoji)
    }
}

#Preview {
    EmojiItem(emoji: "❤️")
}
