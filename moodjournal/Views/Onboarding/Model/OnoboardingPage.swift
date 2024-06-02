//
//  OnoboardingPage.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 25.05.2024.
//

import Foundation
import SwiftUI

// MARK: - FRUITS DATA

let onboardingData: [Onboarding] = [
    Onboarding(
      title: "Log Your Feelings",
      headline: "Describe your feelings 🙂 using emojis.",
      image: "feelings",
      gradientColors: [Color("ColorBlueberryLight"), Color("ColorBlueberryDark")]
    ),
    Onboarding(
      title: "Statistics",
      headline: "You can track your monthly 📈 feelings. ",
      image: "analytics",
      gradientColors: [Color("ColorStrawberryLight"), Color("ColorStrawberryDark")]
    ),
    Onboarding(
      title: "AI Assistant",
      headline: "You can ask 🙋 AI for any kind of assistance.",
      image: "secretary",
      gradientColors: [Color("ColorLemonLight"), Color("ColorLemonDark")]
    ),
    Onboarding(
      title: "Privacy",
      headline: "Your privacy is our 🥇 priority.",
      image: "safety",
      gradientColors: [Color("ColorPlumLight"), Color("ColorPlumDark")]
    ),
    Onboarding(
      title: "Have fun",
      headline: "Just have fun made with ❤️",
      image: "happiness",
      gradientColors: [Color("ColorLimeLight"), Color("ColorLimeDark")]
    ),
    Onboarding(
      title: "Sign Up",
      headline: "Create account or be Anonymous",
      image: "unknown",
      gradientColors: [Color("ColorLimeLight"), Color("ColorLimeDark")]
    ),
]
