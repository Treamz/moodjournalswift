//
//  MoodCarousel.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI

struct MoodCarousel: View {
    
    private var items = ["😡", "😞", "😐", "🙂", "😊", "😁"]
    var body: some View {
        ScrollView(.horizontal,showsIndicators: false) {
                   LazyHStack {
                       ForEach(0..<items.count) { i in
                           
                           Circle().containerRelativeFrame(.horizontal,count: 1, spacing: 1)
                               .foregroundStyle(.red)
                               .overlay {
                                   Text(items[i])
                                       .font(.system(size: 90))
                               }
//                               .scrollTransition { content, phase in
//                                   content
////                                       .opacity(phase.isIdentity ? 1 : 0)
//                                       .scaleEffect(x: phase.isIdentity ? 1:0.3,y: phase.isIdentity ? 1:0.3)
//                                       .offset(y: phase.isIdentity ? 0 : 50)
//                                   
//                               }
                       }
                   }
                   .scrollTargetLayout()
               }
               .scrollTargetBehavior(.viewAligned)
               .defaultScrollAnchor(.center)
               .safeAreaPadding(.horizontal, 40)
               .frame(height: 200)
    
    }
}

#Preview {
    MoodCarousel()
}
