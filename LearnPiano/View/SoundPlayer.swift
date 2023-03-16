//
//  SoundPlayerView.swift
//  keyb13
//
//  Created by Артём Коротков on 10.01.2023.
//

import UIKit
import SnapKit

class SoundPlayer: UIView {
    
    weak var delegate: VisualSoundPlayerDelegate!
    
    //MARK: Public properties
    var targetAction: [TargetAction] = []
    
    //MARK: - Private properties
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
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func configureView() {
        let stackView = UIStackView(arrangedSubviews: [playButton, stopButton, plusButton, minusButton, repeatButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        addSubview(stackView)
        
        stackView.subviews.forEach { button in
            button.snp.makeConstraints { make in
                make.height.width.equalTo(100)
            }
        }
        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func addActions() {
        let playAction = TargetAction {
            //            self.conductor.play()
            self.delegate.playMidi()
        }
        let stopAction = TargetAction {
            self.delegate.stopMidi()
        }
        let plusAction = TargetAction {
            self.delegate.plusInterval()
        }
        let minusAction = TargetAction {
            self.delegate.minusInterval()
        }
        let repeatAction = TargetAction {
            self.delegate.repeatMidi()
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
