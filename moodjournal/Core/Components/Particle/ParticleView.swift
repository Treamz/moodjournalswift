//
//  ParticleView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 05.06.2024.
//

import SwiftUI


struct ParticleView: View {
    @State private var particles: [Particle] = []
    let updateTimer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    let spawnTimer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles, id: \.position.x) { particle in
                    Text(particle.emoji)
                        .font(.system(size: 24))
                        .opacity(particle.alpha)
                        .position(x: particle.position.x, y: particle.position.y)
                }
            }
            .background(.white)
            .onReceive(updateTimer) { _ in
                updateParticles(in: geometry.size)
            }
            .onReceive(spawnTimer) { _ in
                spawnParticle(in: geometry.size)
            }
            .onAppear {
                spawnParticle(in: geometry.size)
            }
        }
    }

    private func spawnParticle(in size: CGSize) {
        let position = CGPoint(x: Double.random(in: 0...size.width), y: size.height)
        let velocity = CGVector(dx: Double.random(in: -1...1), dy: Double.random(in: -3...0))
        let emojiOptions = ["🌟", "❄️", "✨", "🔥", "🍂"]
        let randomEmoji = emojiOptions.randomElement() ?? "✨"
        let particle = Particle(position: position, velocity: velocity, alpha: 1, lifespan: 3, emoji: randomEmoji)
        particles.append(particle)
    }

    private func updateParticles(in size: CGSize) {
        for index in particles.indices {
            var particle = particles[index]
            particle.position = CGPoint(x: particle.position.x + particle.velocity.dx, y: particle.position.y + particle.velocity.dy)
            particle.lifespan -= 0.05
            particle.alpha = max(0, particle.lifespan / 3)
            particles[index] = particle
        }
        particles = particles.filter { $0.lifespan > 0 }
    }
}


#Preview {
    ParticleView()
                .frame(width: 300, height: 600)
                .background(Color.black)
}
