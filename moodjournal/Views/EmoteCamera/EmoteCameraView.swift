//
//  EmoteCameraView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.06.2024.
//

import SwiftUI

struct EmoteCameraView: View {
    @Environment(\.dismiss) var dismiss

    @State private var data = ""
    
    @State private var lastEmotions: [Mood] = []
    
    @EnvironmentObject private var homeViewModel: HomeViewModel
    
//    var onDataChange: (String) -> Void


    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50)),
        GridItem(.adaptive(minimum: 50)),
      ]
    var body: some View {
        ZStack(alignment: .top) {
            EmoteCameraViewWrapper(identifier: $data)
            VStack {
                Button("Dismiss") {
                    dismiss()
                }
                .padding()
                .foregroundStyle(.white)
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(Capsule())
                Spacer()
                LazyVGrid(columns: adaptiveColumn) {
                    ForEach(0..<lastEmotions.count, id: \.self) { emotion in
                        Text(lastEmotions[emotion].emoji)
                            .font(.system(size: 70))
                            .onTapGesture(.heavy) {
                            Task {
                                let mood = lastEmotions[emotion]
                                try await homeViewModel.addMood(forDate:.now, mood: mood.emoji)
                            }
                                dismiss()
                            }
                    }
                }
            }
        }
        .onChange(of: data) { oldValue, newValue in
            let data = EmotionService.getEmojisByText(text: newValue)
            data.forEach { element in
                if(!lastEmotions.contains(element)) {
                    lastEmotions.append(element)
                }
            }
//            var tempArray = lastEmotions
//            tempArray.append(contentsOf: data)
//            let unique = Array(Set(tempArray))
//            lastEmotions = unique
//            if(!lastEmotions.contains(newValue)) {
//                lastEmotions.append(newValue)
//            }
        }
    }
}

#Preview {
    EmoteCameraView()
}
