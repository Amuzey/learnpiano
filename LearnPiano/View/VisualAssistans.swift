//
//  VisualAssistans.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import UIKit
import MidiParser

protocol SoundPlayerControlDelegate: AnyObject {
    func plusInterval()
    func minusInterval()
    func repeatMidi()
    func playMidi()
    func stopMidi()
}

protocol KeyboardControlDelegate: AnyObject {
    func didTapKey(note: Int)
}

protocol PanelControlDelegate: AnyObject {
    func didTapLeftHandButton()
    func didTapRightHandButton()
}

class VisualAssistans: UIView {
    
    var delegate: KeyboardDelegate!
    
    //MARK: - Private properties
    private let keyboardSheme = KeyboardSheme.shared
    private let midiLeft = MidiParser(midiName: "leftHand")
    private let midiRight = MidiParser(midiName: "rightHand")
    private var timer: Timer?
    private var timeInterval =  0.0185
    private var yOffset: CGFloat = 0
    private var clickedNote: Int?
    private var leftIsHiden = true {
        didSet {
            delegate.resetButtonColor()
            setNeedsDisplay()
        }
    }
    private var rightIsHiden = true {
        didSet {
            delegate.resetButtonColor()
            setNeedsDisplay()
        }
    }
    private lazy var width = (UIScreen.main.bounds.width - 200) / 51
    private lazy var trackLeft = midiLeft.midi.noteTracks[1]
    private lazy var trackRight = midiRight.midi.noteTracks[1]
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycles methods
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        for note in trackLeft {
            let center = getCenter(note: note)
            let color = leftIsHiden ? setColor(note: note) : UIColor.clear.cgColor
            drawRect(context: context, center: center, height: CGFloat(note.duration.inSeconds * 120), color: color)
        }
        for note in trackRight {
            let center = getCenter(note: note)
            let color = rightIsHiden ? setColor(note: note) : UIColor.clear.cgColor
            drawRect(context: context, center: center, height: CGFloat(note.duration.inSeconds * 120), color: color)
        }
    }
    
    deinit {
        stopTimer()
    }
    
    //MARK: Private methods
    private func setColor(note: MidiNoteTrack.Element) -> CGColor {
            return UIColor.systemYellow.cgColor
    }
    
    private func getCenter(note: MidiNoteTrack.Element) -> CGPoint {
        let centerX = (keyboardSheme.buttons[Int(note.note) - 21].frame.minX)
        let centerY = CGFloat(Int(bounds.height - CGFloat(note.timeStamp.inSeconds) * 120) - 100)
        return CGPoint(x: centerX, y: centerY + yOffset)
    }
    
    private func drawRect(context: CGContext, center: CGPoint, height: CGFloat, color: CGColor) {
        context.setFillColor(color)
        context.beginPath()
        context.addRect(CGRect(x: center.x, y: center.y, width: width, height: height))
        context.closePath()
        context.fillPath()
    }
    
    private func startTimer(timeInterval: Double) {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            self?.updateCirclesPosition()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateCirclesPosition() {
        yOffset += 1
        setNeedsDisplay()
        pressKeysForMusic()
    }
    
    private func pressKeysForMusic() {
        for note in trackLeft {
            let center = getCenter(note: note)
            if Int(center.y) + Int(note.duration.inSeconds * 120) == Int(bounds.height), leftIsHiden {
                delegate.pressedButton(note: Int(note.note))
            } else if Int(center.y) == Int(bounds.height), leftIsHiden {
                delegate.releaseButton(note: Int(note.note))
            }
        }
        for note in trackRight {
            let center = getCenter(note: note)
            if Int(center.y) + Int(note.duration.inSeconds * 120) == Int(bounds.height), rightIsHiden {
                delegate.pressedButton(note: Int(note.note))
            } else if Int(center.y) == Int(bounds.height), rightIsHiden {
                delegate.releaseButton(note: Int(note.note))
            }
        }
    }
}


//MARK: VisualSoundPlayerDelegate, KeyboardControlDelegate
extension VisualAssistans: SoundPlayerControlDelegate, KeyboardControlDelegate {
    func playMidi() {
        if timer == nil {
            startTimer(timeInterval: timeInterval)
        }
    }
    
    func stopMidi() {
        stopTimer()
    }
    
    func plusInterval() {
        timeInterval -= 0.0015
        stopTimer()
        startTimer(timeInterval: timeInterval)
    }
    func minusInterval() {
        timeInterval += 0.0015
        stopTimer()
        startTimer(timeInterval: timeInterval)
    }
    
    func repeatMidi() {
        yOffset = 0
        stopTimer()
        delegate.resetButtonColor()
        setNeedsDisplay()
    }
    
    func didTapKey(note: Int) {
        if note == clickedNote {
            keyboardSheme.buttons[note].isCorect?.toggle()
            playMidi()
        }
    }
}

extension VisualAssistans: PanelControlDelegate {
    func didTapLeftHandButton() {
        leftIsHiden.toggle()
    }
    
    func didTapRightHandButton() {
        rightIsHiden.toggle()
    }
}
