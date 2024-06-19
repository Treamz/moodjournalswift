//
//  MoodsRow.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 19.05.2024.
//

import SwiftUI

struct MoodsRow: View {
    @State private var showingCredits = false
    
    @State private var isPresentingMood: MoodItem? = nil


    @State private var currentItem : MoodItem = MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: "")
    var moods: [MoodItem]
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 40))
       ]
       
    var body: some View {
        ScrollView{
            LazyVStack() {
                ForEach(Array(moods.reversed().enumerated()), id:\.self.element.id) { index, mood in
                          MoodTimeLineItem(item: mood)
                              .onTapGesture {
                                                                    isPresentingMood = mood
                                  
                              }
                      }
                  }
                  
              }
        .animation(.default, value: moods.count)
        .padding()
        .sheet(item: $isPresentingMood) { mood in
            EditNoteView(currentItem:mood, newItemPresented: $showingCredits )
                }
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.hidden)
       
    }
    
    private func itemWidth(at index: Int, in totalWidth: CGFloat, itemCount: Int) -> CGFloat {
        let remainingWidth = totalWidth - (CGFloat(index) * 10.0) // Adjust the offset as needed
        let itemWidth = remainingWidth / CGFloat(itemCount - index)
        return itemWidth
    }
}

#Preview {
    MoodsRow(moods: [MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),])
}
