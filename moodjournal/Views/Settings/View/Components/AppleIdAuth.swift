//
//  AppleIdAuth.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 25.05.2024.
//

import SwiftUI

struct AppleIdAuth: View {
    @StateObject private var vm: AppViewModel = AppViewModel()
    var body: some View {
        VStack {
            Label("Sign in with Apple",systemImage: "link")
                .onTapGesture {
                    //vm.signIn()
                }
        }
    }
}

#Preview {
    AppleIdAuth()
}
