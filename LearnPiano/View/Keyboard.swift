//
//  PianoKeyboard.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import UIKit
import AudioKit
import SnapKit

class Keyboard: UIView {
    private let conductor = MIDIMonitorConductor()
    private var keyboardSheme = KeyboardSheme.shared
    var targetAction: [TargetAction] = []
    let height: CGFloat = 100
    let width = (UIScreen.main.bounds.width - 200) / 51
    var buttons: [Int: UIButton] = [:]
    var keyboardButtons: [KeyboardButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup(width: width, height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(width: Double, height: CGFloat) {
        var buttons: [Int: UIButton] = [:]
        var blackBtn: [Int] = []
        
        var counter = 21
        for number in 0..<51 {
            let whiteButton = UIButton()
            whiteButton.backgroundColor = .white
            addSubview(whiteButton)
            sendSubviewToBack(whiteButton)
            createButtons(button: whiteButton, number: counter)
            buttons[counter] = whiteButton
            let buttonFrame = CGRect(x: (width + 4) * Double(number), y: 0, width: Double(width), height: Double(height))
            let keyboardButton = KeyboardButton(number: counter, frame: buttonFrame, button: whiteButton)
            keyboardButtons.append(keyboardButton)
            counter += 1
            
            whiteButton.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset((width + 4) * Double(number))
                make.bottom.equalToSuperview()
                make.width.equalTo(width)
                make.height.equalTo(height)
            }
            var mas = [0]
            for i in 0...7 {
                mas.append(contentsOf: [2 + 7 * i, 3 + 7 * i, 5 + 7 * i, 6 + 7 * i, 7 + 7 * i])
            }
            if mas.contains(number) {
                let blackButton = UIButton()
                addSubview(blackButton)
                let blackButtonFrame = CGRect(x: (width + 4) * Double(number) + width / 2, y: 0, width: Double(width), height: Double(height / 2))
                let blackKeyboardButton = KeyboardButton(number: counter, frame: blackButtonFrame, button: blackButton)
                keyboardButtons.append(blackKeyboardButton)
                blackButton.backgroundColor = .black
                createButtons(button: blackButton, number: counter)
                blackButton.snp.makeConstraints { make in
                    make.leading.equalToSuperview().offset((width + 4) * Double(number) + width / 2)
                    make.top.equalToSuperview()
                    make.height.equalTo(height / 2)
                    make.width.equalTo(width)
                }
                blackBtn.append(counter)
                buttons[counter] = blackButton
                counter += 1
            }
        }
        keyboardSheme.saveButtons(buttons: keyboardButtons)
        
        conductor.data.signalOn = { note in
            print("singnalOn", note)
            buttons[note]?.backgroundColor = .red
        }
        
        conductor.data.signalOff = { note in
            print("singnalOff", note)
            buttons[note]?.backgroundColor = .white
            if blackBtn.contains(note) {
                buttons[note]?.backgroundColor = .black
            } else {
                buttons[note]?.backgroundColor = .white
            }
        }
    }
    
    private func createButtons(button: UIButton, number: Int) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 3
        button.layer.maskedCorners = [.layerMinXMaxYCorner,
                                      .layerMaxXMaxYCorner]
        
        let btnColor = button.backgroundColor
        let stop =
        TargetAction {
            if self.conductor.playing {
                button.backgroundColor = .red
                self.conductor.instrument.stop(noteNumber: MIDINoteNumber(number), channel: 0)
                self.keyboardSheme.click(note: number)
            }
        }
        
        let getWhite =
        TargetAction {
            button.backgroundColor = btnColor
        }
        
        let play =
        TargetAction {
            self.conductor.playing = true
            button.backgroundColor = btnColor
            try? self.conductor.engine.start()
            self.conductor.instrument.play(noteNumber: MIDINoteNumber(number), velocity: 70, channel: 0)
            self.keyboardSheme.click(note: number)
            print(">>>> ", number)
        }
        
        targetAction.append(play)
        targetAction.append(stop)
        targetAction.append(getWhite)
        
        button.addTarget(stop, action: #selector(TargetAction.action), for: .touchDown)
        button.addTarget(getWhite, action: #selector(TargetAction.action), for: .touchDragExit)
        button.addTarget(play, action: #selector(TargetAction.action), for: .touchUpInside)
    }
    
    private func getHidden(btn: UIButton, number: Int) {
        btn.tag = number
        switch number {
        case 1, 4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46:
            btn.isHidden = true
        default:
            btn.isHidden = false
        }
    }
}
