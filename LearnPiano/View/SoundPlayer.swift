//
//  SoundPlayerView.swift
//  keyb13
//
//  Created by Артём Коротков on 10.01.2023.
//

import UIKit
import SnapKit

class SoundPlayer: UIView {
    var targetAction: [TargetAction] = []
    private let conductor = MIDIMonitorConductor()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let stopButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "stop.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let repeatButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "repeat.circle"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        let stackView = UIStackView(arrangedSubviews: [playButton, stopButton, plusButton, minusButton, repeatButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func addActions() {
        let playAction = TargetAction {
            self.conductor.play()
        }
        let stopAction = TargetAction {
            self.conductor.stopThis()
        }
        let plusAction = TargetAction {
            print("+")
        }
        let minusAction = TargetAction {
            print("-")
        }
        let repeatAction = TargetAction {
            print("repeat")
        }
        targetAction.append(playAction)
        targetAction.append(stopAction)
        targetAction.append(plusAction)
        targetAction.append(minusAction)
        targetAction.append(repeatAction)
        playButton.addTarget(playAction, action: #selector(TargetAction.action), for: .touchUpInside)
        stopButton.addTarget(stopAction, action: #selector(TargetAction.action), for: .touchUpInside)
        plusButton.addTarget(plusAction, action: #selector(TargetAction.action), for: .touchUpInside)
        minusButton.addTarget(minusAction, action: #selector(TargetAction.action), for: .touchUpInside)
        repeatButton.addTarget(repeatAction, action: #selector(TargetAction.action), for: .touchUpInside)
    }
}
