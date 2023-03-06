//
//  ViewController.swift
//  LearnPiano
//
//  Created by Alexey Nikiforov on 20.01.2023.
//

import UIKit
import AudioKit
import SnapKit

class ViewController: UIViewController {
    
    //    private let conductor = MIDIMonitorConductor()
    
    private let visualAssistans = VisualAssistans()
    private let keyboard = Keyboard()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>")
        view.addSubview(visualAssistans)
        view.addSubview(keyboard)
        setupViewAssistans()
        setupKeyBoard()
    }
    
    private func setupKeyBoard() {
        keyboard.backgroundColor = .lightGray
        keyboard.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupViewAssistans() {
        visualAssistans.backgroundColor = .darkGray
        visualAssistans.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(keyboard.snp_topMargin)
            make.height.equalTo(view.bounds.height / 3)
        }
    }
}

