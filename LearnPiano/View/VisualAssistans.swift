//
//  VisualAssistans.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import UIKit
import MidiParser

protocol VisualSoundPlayerDelegate: AnyObject {
    func plusInterval()
    func minusInterval()
    func repeatMidi()
    func playMidi()
    func stopMidi()
}

protocol VisualKeyboardDelegate: AnyObject {
    func clickButton(note: Int)
}

class VisualAssistans: UIView {
    
    var delegate: KeyboardDelegate!
    
    //MARK: - Private properties
    private let keyboardSheme = KeyboardSheme.shared
    private let midiLeft = MidiParser(midiName: "leftHand")
    private let midiRight = MidiParser(midiName: "rightHand")
    private var timer: Timer?
    private var timeInterval =  0.0125
    private var yOffset: CGFloat = 0
    private var clickedNote: Int?
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
        for note in trackRight {
            let center = getCenter(note: note)
            let color = setColor(note: note)
            drawRect(context: context, center: center, height: CGFloat(note.duration.inTicks.value / 8), color: color)
        }
        for note in trackLeft {
            let center = getCenter(note: note)
            let color = setColor(note: note)
            drawRect(context: context, center: center, height: CGFloat(note.duration.inTicks.value / 8), color: color)
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
        let centerY = CGFloat(Int(bounds.height - CGFloat(note.timeStamp.inTicks.value) / 5))
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
        
        for note in trackLeft {
            let center = getCenter(note: note)
            if Int(center.y) + Int(note.duration.inTicks.value / 8) == Int(bounds.height) {
//                stopTimer()
                delegate.pressedButton(note: Int(note.note))
            } else if Int(center.y) == Int(bounds.height) {
                delegate.releaseButton(note: Int(note.note))
            }
        }
   
        for note in trackRight {
            let center = getCenter(note: note)
            if Int(center.y) + Int(note.duration.inTicks.value / 8) == Int(bounds.height) {
//                stopTimer()
                delegate.pressedButton(note: Int(note.note))
            } else if Int(center.y) == Int(bounds.height) {
                delegate.releaseButton(note: Int(note.note))
            }
        }
    }
}


//MARK: VisualSoundPlayerDelegate, VisualKeyboardDelegate
extension VisualAssistans: VisualSoundPlayerDelegate, VisualKeyboardDelegate {
    func playMidi() {
        if timer == nil {
            startTimer(timeInterval: timeInterval)
        }
    }
    
    func stopMidi() {
        stopTimer()
    }
    
    func plusInterval() {
        timeInterval -= 0.0010
        stopTimer()
        startTimer(timeInterval: timeInterval)
    }
    func minusInterval() {
        timeInterval += 0.0010
        stopTimer()
        startTimer(timeInterval: timeInterval)
    }
    
    func repeatMidi() {
        yOffset = 0
        stopTimer()
        delegate.resetButtonColor()
        setNeedsDisplay()
    }
    
    func clickButton(note: Int) {
        if note == clickedNote {
            keyboardSheme.buttons[note].isCorect?.toggle()
            playMidi()
        }
    }
}
