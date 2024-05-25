//
//  Home.swift
//  CircularSlider
//
//  Created by mk on 2023/07/05.
//

import SwiftUI

struct SnapCarousel: View {
    var onDataChange: (String) -> Void

    private let items = ["😡", "😞", "😐", "🙂", "😊", "😁"]
    
    @State private var activeID: Int? = 4
    
    var body: some View {
        VStack {
        

            GeometryReader {
                let size = $0.size
                let padding = (size.width - 70) / 2
                
                ScrollViewReader { scrollViewProxy in
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 35) {
                            ForEach(items.indices, id: \.self) { index in
                                Circle()
                                    .overlay {
                                        Text(items[index])
                                            .font(.system(size: 60))
                                    }
                                    .background(Color.red)
                                    .frame(width: 70, height: 70)
                                    .clipShape(.circle)
                                    .shadow(color: .black.opacity(0.15), radius: 5, x: 5, y: 5)
                                    .visualEffect { view, proxy in
                                        view
                                            .offset(y: offset(proxy))
                                            .offset(y: scale(proxy) * 15)
                                    }
                                    .scrollTransition(.interactive, axis: .horizontal) { view, phase in
                                        view
                                            .scaleEffect(phase.isIdentity && activeID == index ? 1 : 1, anchor: .bottom)
                                    }
                                    .onTapGesture {
                                        onDataChange(items[index])
                                    }
                            }
                        }
                        .frame(height: size.height)
                        .offset(y: -30)
                        .scrollTargetLayout()
                        
                    }
                    .background(content: {
                        Circle()
                            .fill(.white.shadow(.drop(color: .black.opacity(0.2), radius: 5)))
                            .frame(width: 85, height: 85)
                            .offset(y: -15)
                    })
                    .safeAreaPadding(.horizontal, padding)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $activeID)
                    .frame(height: size.height)
                    .onAppear {
                                            // Scroll to the default activeID position
                                            withAnimation {
                                                scrollViewProxy.scrollTo(3, anchor: .center)
                                            }
                                        }
                    
                }
            }
            .frame(height: 200)
//            .background(Color.red)
        }
        .ignoresSafeArea(.container, edges: .bottom)
    }
    
    func offset(_ proxy: GeometryProxy) -> CGFloat {
        let progress = progress(proxy)
        return progress < 0 ? progress * -30 : progress * 30
    }
    
    func scale(_ proxy: GeometryProxy) -> CGFloat {
        let progress = min(max(progress(proxy), -1), 1)
        return progress < 0 ? 1 + progress : 1 - progress
    }
    
    func progress(_ proxy: GeometryProxy) -> CGFloat {
        let viewWidth = proxy.size.width
        let minX = (proxy.bounds(of: .scrollView)?.minX ?? 0)
        return minX / viewWidth
    }
}

#Preview {
    SnapCarousel(onDataChange: { newData in        print("newData \(newData)")
    })
}

// Slider Type
enum TripPicker: String, CaseIterable {
    case scaled = "Scaled"
    case normal = "Normal"
}
