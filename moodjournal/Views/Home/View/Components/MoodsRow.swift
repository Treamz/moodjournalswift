//
//  MoodsRow.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import SwiftUI

struct MoodsRow: View {
    var moods: [MoodItem]
    var body: some View {
        HStack(spacing: -15) {
            ForEach(Array(moods.reversed().enumerated()), id: \.offset) { index, mood in
                Text(mood.title)
                    .font(.system(size: 30))
            }
            Spacer()
        }
        .padding(.horizontal,20)
    }
    
    private func itemWidth(at index: Int, in totalWidth: CGFloat, itemCount: Int) -> CGFloat {
        let remainingWidth = totalWidth - (CGFloat(index) * 10.0) // Adjust the offset as needed
        let itemWidth = remainingWidth / CGFloat(itemCount - index)
        return itemWidth
    }
}

#Preview {
    MoodsRow(moods: [MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow),])
}
