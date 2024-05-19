//
//  EmojiShowerViewController.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 18.05.2024.
//
import UIKit

class EmojiShowerViewController: UIViewController {
    
    private var emojiEmitter: CAEmitterLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func startEmojiShower() {
        createEmojiShower()
        // Stop the shower after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.stopEmojiShower()
        }
    }
    
    private func stopEmojiShower() {
        emojiEmitter?.birthRate = 0
        // Optionally, remove the emitter after a delay to allow existing emojis to disappear
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.emojiEmitter?.removeFromSuperlayer()
        }
    }
    
    // Function to create the emoji shower effect
    private func createEmojiShower() {
        let emojiEmitter = CAEmitterLayer()
        self.emojiEmitter = emojiEmitter
        
        // Position the emitter at a specific location just below the screen
        emojiEmitter.emitterPosition = CGPoint(x: view.center.x, y: view.frame.size.height)
        emojiEmitter.emitterShape = .line
        emojiEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let emojis = ["😀", "😍", "🥳", "😎", "🚀", "🥳", "🎉", "🤩"] // List of emojis to use
        
        var emojiCells = [CAEmitterCell]()
        
        // Create emitter cells for each emoji
        for emoji in emojis {
            let cell = makeEmojiEmitterCell(emoji: emoji)
            emojiCells.append(cell)
        }
        
        // Set the emitter cells for the emoji emitter
        emojiEmitter.emitterCells = emojiCells
        
        // Add the emoji emitter to the view's layer
        view.layer.addSublayer(emojiEmitter)
    }
    
    // Function to create an emitter cell for a specific emoji
    private func makeEmojiEmitterCell(emoji: String) -> CAEmitterCell {
        let cell = CAEmitterCell()
        
        // Set the birth rate (how frequently emojis appear) and lifetime (how long they last)
        cell.birthRate = 3
        cell.lifetime = Float.random(in: 3.0...5.0)
        cell.lifetimeRange = 0
        
        // Set the initial velocity and velocity range for the emojis
        cell.velocity = CGFloat.random(in: 100...200)
        cell.velocityRange = -50
        
        // Configure the direction and range of emoji emission
        cell.emissionLongitude = -CGFloat.pi / 4
        cell.emissionRange = CGFloat.pi / 4
        
        // Set rotation and scale properties for emojis
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        
        // Create the emoji image from the text
        if let emojiImage = imageFrom(emoji: emoji) {
            cell.contents = emojiImage.cgImage
        }
        
        return cell
    }
    
    // Function to create an image from emoji text
    private func imageFrom(emoji: String) -> UIImage? {
        let label = UILabel()
        label.text = emoji
        label.font = UIFont.systemFont(ofSize: 30)
        label.sizeToFit()
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, UIScreen.main.scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            label.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        
        return nil
    }
}
