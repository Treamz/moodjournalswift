//
//  FFButton.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 02.06.2024.
//

import SwiftUI

struct FFButton: View {
    let title: String
    let background: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                     .foregroundColor(background)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
        .frame(height: 60)
    }
}

#Preview {
    FFButton(title: "Button", background: Color.red) {
        
    }
}
