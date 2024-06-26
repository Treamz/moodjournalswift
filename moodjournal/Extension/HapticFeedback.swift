//
//  HapticFeedback.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 13.06.2024.
//

import SwiftUI

func withFeedback(
  _ style: UIImpactFeedbackGenerator.FeedbackStyle,
  _ action: @escaping () -> Void
) -> () -> Void {
  { () in
    let impact = UIImpactFeedbackGenerator(style: style)
    impact.prepare()
    impact.impactOccurred()
    action()
  }
}

struct HapticTapGestureViewModifier: ViewModifier {
  var style: UIImpactFeedbackGenerator.FeedbackStyle
  var action: () -> Void

  func body(content: Content) -> some View {
    content.onTapGesture(perform: withFeedback(self.style, self.action))
  }
}

extension View {
  func onTapGesture(
    _ style: UIImpactFeedbackGenerator.FeedbackStyle,
    perform action: @escaping () -> Void
  ) -> some View {
    modifier(HapticTapGestureViewModifier(style: style, action: action))
  }
}

extension Button {
  init(
    _ style: UIImpactFeedbackGenerator.FeedbackStyle,
    action: @escaping () -> Void,
    @ViewBuilder label: () -> Label
  ) {
    self.init(action: withFeedback(style, action), label: label)
  }
}
