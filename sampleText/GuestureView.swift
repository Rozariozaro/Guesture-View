//
//  GuestureView.swift
//  sampleText
//
//  Created by Rozario on 10/12/17.
//  Copyright © 2017 VisionReached. All rights reserved.
//

import UIKit


class GestureView: UIView, UIGestureRecognizerDelegate {
    private var initialTransform: CGAffineTransform?
    private var gestures = Set<UIGestureRecognizer>(minimumCapacity: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGuestureRecognizers()
    }
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
    
    func setupGuestureRecognizers() {
        let rotateGuesture = UIRotationGestureRecognizer(target: self, action: #selector(processGesture(_:)))
        rotateGuesture.delegate = self
        self.addGestureRecognizer(rotateGuesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(processGesture(_:)))
        pinchGesture.delegate = self
        self.addGestureRecognizer(pinchGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(processGesture(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
    }
    
    @objc private func processGesture(_ sender: UIGestureRecognizer) {
        switch sender.state {
        case .began:
            if gestures.count == 0 {
                initialTransform = sender.view?.transform
            }
            gestures.insert(sender)
        case .changed:
            if var initial = initialTransform {
                gestures.forEach({ (sender) in
                    initial = transformUsingRecognizer(sender, transform: initial)
                })
                sender.view?.transform = initial
            }
        case .ended:
            gestures.remove(sender)
        default:
            break
        }
    }
    
    @objc private func transformUsingRecognizer(_ recognizer: UIGestureRecognizer, transform: CGAffineTransform) -> CGAffineTransform {
        if let rotateRecognizer = recognizer as? UIRotationGestureRecognizer {
            return transform.rotated(by: rotateRecognizer.rotation)
        }
        if let pinchRecognizer = recognizer as? UIPinchGestureRecognizer {
            let scale = pinchRecognizer.scale
            return transform.scaledBy(x: scale, y: scale)
        }
        if let panRecognizer = recognizer as? UIPanGestureRecognizer {
            let deltaX = panRecognizer.translation(in: recognizer.view).x
            let deltaY = panRecognizer.translation(in: recognizer.view).y
            return transform.translatedBy(x: deltaX, y: deltaY)
        }
        return transform
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
