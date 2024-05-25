//
//  MoodsRow.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import SwiftUI

struct MoodsRow: View {
    var moods: [MoodItem]
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 40))
       ]
       
    var body: some View {
        ScrollView{
            LazyVGrid(columns: adaptiveColumn, spacing: 0) {
                      ForEach(Array(moods.reversed().enumerated()), id: \.offset) { index, mood in
                          Text(mood.title)
//                              .background(Color.red)
                              .frame(width: 50, height: 50, alignment: .center)
                              .font(.system(size: 50))
                      }
                  }
                  
              }
        .padding()
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
