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
    
    //MARK: - Private properties
    private let keyboard = Keyboard()
    private let visualAssistans = VisualAssistans()
    private let soundPlayer = SoundPlayer()
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>")
        setupKeyBoard()
        setupViewAssistans()
        setupSoundPlayer()
        soundPlayer.delegate = visualAssistans
    }
    
    //MARK: - Private methods
    private func setupKeyBoard() {
        view.addSubview(keyboard)
        keyboard.backgroundColor = .lightGray
        keyboard.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupViewAssistans() {
        view.addSubview(visualAssistans)
        visualAssistans.backgroundColor = .darkGray
        visualAssistans.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(keyboard.snp_topMargin)
            make.height.equalTo(view.bounds.height / 3)
        }
    }
    
    private func setupSoundPlayer() {
        view.addSubview(soundPlayer)
        soundPlayer.backgroundColor = .lightGray
        soundPlayer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(visualAssistans.snp_topMargin)
            make.height.equalTo(100)
        }
    }
}

