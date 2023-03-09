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
            drawRect(context: context, center: center, height: CGFloat(note.duration.inTicks.value / 8), color: UIColor.systemGreen.cgColor)
        }
        for note in trackLeft {
            let center = getCenter(note: note)
            drawRect(context: context, center: center, height: CGFloat(note.duration.inTicks.value / 8), color: UIColor.systemBlue.cgColor)
        }
    }
    
    func getCenter(note: MidiNoteTrack.Element) -> CGPoint {
        var centerX: CGFloat = 0
        var centerY: CGFloat = 0
        if keyboardSheme.blackButtons.contains(Int(note.note)) {
            centerX = (width + 4) * CGFloat(note.note - 21) + width / 2
            centerY = CGFloat(Int(bounds.height - CGFloat(note.timeStamp.inTicks.value) / 5))
            return CGPoint(x: centerX, y: centerY + CGFloat(yOffset))
        } else {
            centerX = (width + 4) * Double(note.note - 21)
            centerY = CGFloat(Int(bounds.height - CGFloat(note.timeStamp.inTicks.value) / 5))
            return CGPoint(x: centerX, y: centerY + CGFloat(yOffset))
        }
    }
    
    //MARK: Private func
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

