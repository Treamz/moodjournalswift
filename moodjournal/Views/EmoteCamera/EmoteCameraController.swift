//
//  EmoteCameraController.swift
//  moodjournal
//
//  Created by Иван Чернокнижников on 17.06.2024.
//

import Foundation
import UIKit
import ARKit

protocol EmoteCameraViewControllerDelegate: AnyObject {
    func clasificationOccured(_ viewController: EmoteCameraViewController, identifier: String)
}

class EmoteCameraViewController : UIViewController {
    
    //The sceneview that we are going to display.
    private let sceneView = ARSCNView(frame: UIScreen.main.bounds)
    
    private var textNode: SCNNode?
    
    weak var delegate: EmoteCameraViewControllerDelegate?

//    private let model = try! VNCoreMLModel(for: CNNEmotions().model)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard ARWorldTrackingConfiguration.isSupported else {return}
        view.addSubview(sceneView)
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.session.run(ARFaceTrackingConfiguration(),options: [.resetTracking, .removeExistingAnchors])
        
    }

}

extension EmoteCameraViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = sceneView.device else { return nil }
        let node = SCNNode(geometry: ARSCNFaceGeometry(device: device))
        //Projects the white lines on the face.
        node.geometry?.firstMaterial?.fillMode = .lines
        
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
           guard let faceGeometry = node.geometry as? ARSCNFaceGeometry, textNode == nil else { return }
           addTextNode(faceGeometry: faceGeometry)
       }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor,
            let faceGeometry = node.geometry as? ARSCNFaceGeometry,
            let pixelBuffer = self.sceneView.session.currentFrame?.capturedImage
            else {
            return
        }

        //Updates the face geometry.
        faceGeometry.update(from: faceAnchor.geometry)
        predict(pixelBuffer: pixelBuffer)

//        //Creates Vision Image Request Handler using the current frame and performs an MLRequest.
//        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: .right, options: [:]).perform([VNCoreMLRequest(model: model) { [weak self] request, error in
//                //Here we get the first result of the Classification Observation result.
//                guard let firstResult = (request.results as? [VNClassificationObservation])?.first else { return }
//                DispatchQueue.main.async {
////                print("identifier: \(topResult.identifier), confidence: \(topResult.confidence)")
//                    //Check if the confidence is high enough - used an arbitrary value here - and update the text to display the resulted emotion.
//                    if firstResult.confidence > 0.92 {
//                        print(firstResult.identifier)
//                        (self?.textNode?.geometry as? SCNText)?.string = firstResult.identifier
//                    }
//                }
//            }])
    }
    
    
    func predict(pixelBuffer : CVPixelBuffer) -> EmotionClassifierOutput? {
           do {
               let config = MLModelConfiguration()
               let model = try EmotionClassifier(configuration: config)
               let prediction = try model.prediction(image: pixelBuffer)
               (self.textNode?.geometry as? SCNText)?.string = prediction.classLabel
               delegate?.clasificationOccured(self, identifier: prediction.classLabel)

               print("PREDICTION \(prediction.classLabel)")
           } catch {
               assertionFailure(error.localizedDescription)
           }
           return nil
       }
    
    // Creates a scene node containing yellow coloured text.
    /// - Parameter faceGeometry: the geometry the node is using.
    private func addTextNode(faceGeometry: ARSCNFaceGeometry) {
      let text = SCNText(string: "", extrusionDepth: 1)
      text.font = UIFont.systemFont(ofSize: 20, weight: .medium)
      let material = SCNMaterial()
      material.diffuse.contents = UIColor.systemYellow
      text.materials = [material]
     
      let textNode = SCNNode(geometry: faceGeometry)
      textNode.position = SCNVector3(-0.1, 0.3, -0.5)
      textNode.scale = SCNVector3(0.003, 0.003, 0.003)
      textNode.geometry = text
      self.textNode = textNode
      sceneView.scene.rootNode.addChildNode(textNode)
    }
}
