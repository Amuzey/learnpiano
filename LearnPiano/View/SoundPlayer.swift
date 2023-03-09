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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        addActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        let stackView = UIStackView(arrangedSubviews: [playButton, stopButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        playButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.leading.equalToSuperview()
        }

        stopButton.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
            make.trailing.equalToSuperview()
        }
    }

    func addActions() {
        let forTest = TargetAction {
            self.conductor.stopThis()
        }
        let forTest2 = TargetAction {
            self.conductor.play()
        }
        targetAction.append(forTest)
        targetAction.append(forTest2)
        playButton.addTarget(forTest2, action: #selector(TargetAction.action), for: .touchUpInside)
        stopButton.addTarget(forTest, action: #selector(TargetAction.action), for: .touchUpInside)
    }
}
