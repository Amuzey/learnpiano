//
//  VisualAssistans.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import UIKit
import MidiParser

class VisualAssistans: UIView {
    
    //MARK: - Private properties
    private let keyboardSheme = KeyboardSheme.shared
    private let midiLeft = MidiParser(midiName: "leftHand")
    private let midiRight = MidiParser(midiName: "rightHand")
    private var timer: Timer?
    private var yOffset: CGFloat = 0
    private lazy var width = (UIScreen.main.bounds.width - 200) / 51
    private lazy var trackLeft = midiLeft.midi.noteTracks[1]
    private lazy var trackRight = midiRight.midi.noteTracks[1]
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        startTimer()
        print(trackLeft[0].note)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycles
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
    
    //MARK: Private func
    private func setColor(note: MidiNoteTrack.Element) -> CGColor {
        if keyboardSheme.buttons[Int(note.note)].klick ?? false {
            return UIColor.systemGreen.cgColor
        } else {
            return UIColor.systemYellow.cgColor
        }
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
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.75/60.0, repeats: true) { [weak self] _ in
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
    }
    
    deinit {
        stopTimer()
    }
}

