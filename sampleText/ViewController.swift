//
//  ViewController.swift
//  sampleText
//
//  Created by Rozario on 10/12/17.
//  Copyright © 2017 VisionReached. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vw = GestureView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.backgroundColor = .red
        view.addSubview(vw)
        NSLayoutConstraint.activate([
            vw.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            vw.widthAnchor.constraint(equalToConstant: 200),
            vw.heightAnchor.constraint(equalToConstant: 200),
            vw.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)])
        
    }
}

