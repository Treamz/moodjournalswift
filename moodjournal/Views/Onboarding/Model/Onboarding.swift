//
//  Onboarding.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 25.05.2024.
//

import Foundation
import SwiftUI

// MARK: - FRUITS DATA MODEL

struct Onboarding: Identifiable {
  var id = UUID()
  var title: String
  var headline: String
  var image: String
  var gradientColors: [Color]
}
