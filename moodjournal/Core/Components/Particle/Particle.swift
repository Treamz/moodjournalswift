//
//  Particle.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 05.06.2024.
//
import CoreGraphics
import Foundation

struct Particle {
    var position: CGPoint
    var velocity: CGVector
    var alpha: Double
    var lifespan: TimeInterval
    var emoji: String
}
