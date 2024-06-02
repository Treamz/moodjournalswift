//
//  OnboardingView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 25.05.2024.
//

import SwiftUI

struct OnBoardingView: View {
    // MARK: - PROPERTIES
    
    var onboardingPages: [Onboarding] = onboardingData

    // MARK: - BODY
    
    var body: some View {
      TabView {
          ForEach(Array(onboardingPages.enumerated()),id: \.element.id) { index, item in
          OnboardingCardView(onboarding: item,index: index)
        } //: LOOP
      } //: TAB
      .tabViewStyle(PageTabViewStyle())
      .padding(.vertical, 20)
    }

}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
