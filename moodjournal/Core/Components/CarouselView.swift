//
//  Home.swift
//  CircularSlider
//
//  Created by mk on 2023/07/05.
//

import SwiftUI

struct SnapCarousel: View {
    var onDataChange: (String) -> Void

    @State private var activeID: Int? = 3
    
    @State private var name = "happy"
    

    private let moods: [Mood] = [
        Mood(emoji: "😡", name: "angry"),
        Mood(emoji: "😠", name: "annoyed"),
        Mood(emoji: "😤", name: "frustrated"),
        Mood(emoji: "😊", name: "happy"),
        Mood(emoji: "😢", name: "sad"),
        Mood(emoji: "😭", name: "crying"),
        Mood(emoji: "😔", name: "pensive"),
        Mood(emoji: "😞", name: "disappointed"),
        Mood(emoji: "😒", name: "unamused"),
        Mood(emoji: "😕", name: "confused"),
        Mood(emoji: "😟", name: "worried"),
        Mood(emoji: "😨", name: "fearful"),
        Mood(emoji: "😰", name: "anxious"),
        Mood(emoji: "😩", name: "weary"),
        Mood(emoji: "😫", name: "tired"),
        Mood(emoji: "😴", name: "sleepy"),
        Mood(emoji: "😐", name: "neutral"),
        Mood(emoji: "😶", name: "speechless"),
        Mood(emoji: "🤔", name: "thinking"),
        Mood(emoji: "😏", name: "smirking"),
        Mood(emoji: "🙂", name: "slightly happy"),
        Mood(emoji: "😄", name: "smiling"),
        Mood(emoji: "😁", name: "grinning"),
        Mood(emoji: "😆", name: "laughing"),
        Mood(emoji: "🤣", name: "rolling on the floor"),
        Mood(emoji: "😍", name: "in love"),
        Mood(emoji: "🥰", name: "loved"),
        Mood(emoji: "😎", name: "cool"),
        Mood(emoji: "🤩", name: "star-struck"),
        Mood(emoji: "😌", name: "relieved"),
        Mood(emoji: "😮", name: "surprised"),
        Mood(emoji: "🤯", name: "mind-blown"),
        Mood(emoji: "🥳", name: "partying"),
        Mood(emoji: "😇", name: "innocent"),
        Mood(emoji: "🤗", name: "hugging"),
        Mood(emoji: "🥺", name: "pleading"),
        Mood(emoji: "😶‍🌫️", name: "in a fog"),
        Mood(emoji: "🤥", name: "lying"),
        Mood(emoji: "🙄", name: "eye rolling"),
        Mood(emoji: "😬", name: "grimacing"),
        Mood(emoji: "🥴", name: "woozy"),
        Mood(emoji: "🤒", name: "sick"),
        Mood(emoji: "🤕", name: "hurt"),
        Mood(emoji: "🥵", name: "hot"),
        Mood(emoji: "🥶", name: "cold"),
        Mood(emoji: "🤢", name: "nauseated"),
        Mood(emoji: "😈", name: "devious"),
        Mood(emoji: "😑", name: "expressionless"),
        Mood(emoji: "🤪", name: "zany"),
        Mood(emoji: "🥲", name: "smiling with tears"),
        Mood(emoji: "😃", name: "very happy")
    ]
    
    var body: some View {
        VStack {
        

            GeometryReader {
                let size = $0.size
                let padding = (size.width - 70) / 2
                
                ScrollViewReader { scrollViewProxy in
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 35) {
                            ForEach(moods.indices, id: \.self) { index in
                                Button {
                                    
                                } label: {
                                    Circle()
                                        .overlay {
                                            Text(moods[index].emoji)
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
                                            onDataChange(moods[index].emoji)
                                        }
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                        .frame(height: size.height)
                        .offset(y: -30)
                        .scrollTargetLayout()
                        
                    }
                    .background(content: {
                        ZStack {
                            Circle()
                                .fill(Color("Background").shadow(.drop(color: .black.opacity(0.2), radius: 5)))
                                .frame(width: 85, height: 85)
                                .offset(y: -15)
                        }
                    })
                    .background(content: {
                        Text(moods[activeID ?? 0].name)
                            .offset(y: -80)
                            .frame(width: 300)
                          
                    })
                    .safeAreaPadding(.horizontal, padding)
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .scrollPosition(id: $activeID)
                    .frame(height: size.height)
                    .onChange(of: activeID, {
                        
                    })
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


struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.4 : 1)
            .animation(.linear(duration: 0.2), value: configuration.isPressed)
    }
}
