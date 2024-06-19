//
//  MoodTimeLineItem.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 02.06.2024.
//

import SwiftUI

struct MoodTimeLineItem: View {
    let item  : MoodItem
    
    var timeString = ""
    
    @State private var shouldShowMenu = true
    @EnvironmentObject private var homeViewModel: HomeViewModel

    init(item: MoodItem) {
        self.item = item
        let date = Date(timeIntervalSince1970: item.date)
        let dateFormatter = DateFormatter()

        dateFormatter.timeStyle = .medium
        timeString = dateFormatter.string(from:date)
    }
    var body: some View {
        HStack(alignment: .top,spacing: 30) {
            VStack(spacing: 10) {
                Circle()
                    .fill(Color("Background"))
                    .frame(width: 15,height: 15)
                    .background(
                        Circle()
                            .stroke(Color("Background"),lineWidth: 1)
                            .padding(-3)
                    )
                
                Rectangle()
                    .fill(Color("Background"))
                    .frame(width: 3)
            }
            .offset(x: 5,y: 5)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(item.title)
                    Spacer()
                    Text(timeString)
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
            .background(Color("Background")
            .cornerRadius(15))
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: 15))
            .contextMenu(shouldShowMenu ? ContextMenu {
                    Button {
                        Task {
                            await homeViewModel.deleteMood(mood: item)
                        }
                    } label: {
                        Label("Delete", systemImage: "delete.left")
                    }
            } : nil)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .onAppear {
//            var date = Date(timeIntervalSince1970: item.date)
//            let dateFormatter = DateFormatter()
//
//            dateFormatter.timeStyle = .medium
//            let timeString = dateFormatter.string(from:date)
//
//            print("DATE: \(timeString)")
        }
    }
    
}

//#Preview {
//    MoodTimeLineItem()
//}

#Preview {
    MoodsRow(moods: [MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: "Hello mate"),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "😐", date: Date().timeIntervalSinceNow, note: ""),MoodItem(id: "1", title: "🙂", date: Date().timeIntervalSinceNow, note: ""),])
}
