//
//  MoodTimeLineItem.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 02.06.2024.
//

import SwiftUI

struct MoodTimeLineItem: View {
    let item  : MoodItem
    var body: some View {
        HStack(alignment: .top,spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(.black)
                    .frame(width: 15,height: 15)
                    .background(
                        Circle()
                            .stroke(.black,lineWidth: 1)
                            .padding(-3)
                    )
                
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            .offset(x: 5,y: 5)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(item.title)
                    Spacer()
                    Text(item.date.stringFormatted())
                        .font(.system(size: 14))
                }
                .font(.title)
                .foregroundStyle(.white)
                
                Text(item.note ?? "")
                    .foregroundStyle(.white)
                    .padding(.top,5)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.black).cornerRadius(15))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

//#Preview {
//    MoodTimeLineItem()
//}

#Preview {
    MoodsRow(moods: [MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: "Hello mate"),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),])
}
