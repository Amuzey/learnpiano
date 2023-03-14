//
//  ViewController.swift
//  LearnPiano
//
//  Created by Alexey Nikiforov on 20.01.2023.
//

import UIKit
import AudioKit
import SnapKit

final class ViewController: UIViewController {
    
    //MARK: - Private properties
    private let keyboard = Keyboard()
    private let visualAssistans = VisualAssistans()
    private let soundPlayer = SoundPlayer()
    
    // MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyBoard()
        setupViewAssistans()
        setupSoundPlayer()
        soundPlayer.delegate = visualAssistans
        keyboard.delegate = visualAssistans
    }
    
    //MARK: - Private methods
    private func setupKeyBoard() {
        view.addSubview(keyboard)
        keyboard.backgroundColor = .lightGray
        keyboard.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func setupViewAssistans() {
        view.addSubview(visualAssistans)
        visualAssistans.backgroundColor = .darkGray
        visualAssistans.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
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

