import SwiftUI

struct MoodCarousel: View {
    
    var onDataChange: (String) -> Void

    private let items = ["😡", "😞", "😐", "🙂", "😊", "😁"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(0..<items.count, id: \.self) { i in
                    Circle()
                        .containerRelativeFrame(.horizontal, count: 1, spacing: 1)
                        .foregroundStyle(.red)
                        .overlay {
                            Text(items[i])
                                .font(.system(size: 90))
                        }
                        .onTapGesture {
                            onDataChange(items[i])
                        }
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
    MoodCarousel(onDataChange: { newData in
        print(newData)
    })
}
