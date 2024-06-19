//
//  EmoteCameraView.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.06.2024.
//

import SwiftUI

struct EmoteCameraViewWrapper : UIViewControllerRepresentable {
    
    let identifier: Binding<String>

    typealias UIViewControllerType = EmoteCameraViewController

    
    func makeUIViewController(context: Context) -> EmoteCameraViewController {
        
        let vc = EmoteCameraViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: EmoteCameraViewController, context: Context) {
        //
    }
    // this is very important, this coordinator will be used in `makeUIViewController`
    func makeCoordinator() -> Coordinator {
           Coordinator(identifierBinding: identifier)
    }
    
    
    class Coordinator: EmoteCameraViewControllerDelegate {
            let identifierBinding: Binding<String>
            
            init(identifierBinding: Binding<String>) {
                self.identifierBinding = identifierBinding
            }
            
            func clasificationOccured(_ viewController: EmoteCameraViewController, identifier: String) {
                // whenever the view controller notifies it's delegate about receiving a new idenfifier
                // the line below will propagate the change up to SwiftUI
                identifierBinding.wrappedValue = identifier
            }
        }

}
