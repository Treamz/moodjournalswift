//
//  EmojiShowerView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//

import SwiftUI
import UIKit

struct EmojiShowerView: UIViewControllerRepresentable {
    @Binding var startShower: Bool
    
    func makeUIViewController(context: Context) -> EmojiShowerViewController {
        return EmojiShowerViewController()
    }
    
    func updateUIViewController(_ uiViewController: EmojiShowerViewController, context: Context) {
        if startShower {
            uiViewController.startEmojiShower()
            DispatchQueue.main.async {
                self.startShower = false
            }
        }
    }
}
