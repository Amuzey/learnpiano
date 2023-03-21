//
//  ControlPanel.swift
//  LearnPiano
//
//  Created by Алексей on 20.03.2023.
//

import UIKit

class ControlPanel: UIView {
    
    weak var delegate: PanelControlDelegate!
    var keyboardDelegate: KeyboardDelegate!
    
    //MARK: - Public properties
    var targetAction: [TargetAction] = []
    
    //MARK: - Private properties
    private let leftHandButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "hand.raised.brakesignal"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let rightHandButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "hand.raised.brakesignal"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let soundButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "speaker.wave.2.fill"), for: .normal)
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
        let handStackView = UIStackView(arrangedSubviews: [soundButton, leftHandButton, rightHandButton])
        handStackView.axis = .horizontal
        handStackView.alignment = .center
        handStackView.distribution = .equalCentering
        handStackView.translatesAutoresizingMaskIntoConstraints = false
        handStackView.spacing = 10
        addSubview(handStackView)
        
        handStackView.subviews.forEach { button in
            button.snp.makeConstraints { make in
                make.height.width.equalTo(80)
            }
        }
        handStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
    
    private func addActions() {
        let leftHandAction = TargetAction {
            self.delegate.didTapLeftHandButton()
        }
        let rightHandAction = TargetAction {
            self.delegate.didTapRightHandButton()
        }
        let soundAction = TargetAction {
            self.keyboardDelegate.soundSwitch()
            print("sound")
        }
        targetAction.append(leftHandAction)
        targetAction.append(rightHandAction)
        targetAction.append(soundAction)
        
        leftHandButton.addTarget(leftHandAction, action: #selector(TargetAction.action), for: .touchUpInside)
        rightHandButton.addTarget(rightHandAction, action: #selector(TargetAction.action), for: .touchUpInside)
        soundButton.addTarget(soundAction, action: #selector(TargetAction.action), for: .touchUpInside)
    }
}
