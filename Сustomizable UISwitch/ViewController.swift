//
//  ViewController.swift
//  Сustomizable UISwitch
//
//  Created by Vlad on 30.5.24..
//

import UIKit

class ViewController: UIViewController {
    
    let customSwitch = CustomSwitch(frame: CGRect(x: 0, y: 0, width: 100, height: 77))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func switchStateChanged(_ mуSwitch: CustomSwitch) {
        customSwitch.updateUI()
    }
    private func configureSwitch() {
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        
        customSwitch.addTarget(self, action: #selector(switchStateChanged(_:)), for: .valueChanged)
        customSwitch.center = CGPoint(x: viewWidth / 2, y: viewHeight / 2)
        
        view.addSubview(customSwitch)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureSwitch()
    }
}

