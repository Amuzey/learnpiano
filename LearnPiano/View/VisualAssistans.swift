//
//  VisualAssistans.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import UIKit

class VisualAssistans: UIView {
    
    //MARK: - Private properties
    private let midiLeft = MidiParser(midiName: "leftHand")
    private var midiRight = MidiParser(midiName: "rightHand")
    private var timer: Timer?
    private var yOffset: CGFloat = 0
    private lazy var trackLeft = midiLeft.midi.noteTracks[1]
    private lazy var trackRight = midiRight.midi.noteTracks[1]
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycles
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        for note in trackRight {
            let centerX = (Int(bounds.width) / 88) * Int(note.note)
            let centerY = Int(bounds.height - CGFloat(note.timeStamp.inTicks.value) / 5)
            let center = CGPoint(x: centerX, y: centerY + Int(yOffset))
            let rightColor = UIColor.systemGreen.cgColor
            drawRect(context: context, center: center, height: CGFloat(note.duration.inTicks.value / 8), color: rightColor)
        }
        for note in trackLeft {
            let centerX = (Int(bounds.width) / 88) * Int(note.note)
            let centerY = Int(bounds.height - CGFloat(note.timeStamp.inTicks.value) / 5)
            let center = CGPoint(x: centerX, y: centerY + Int(yOffset))
            let leftColor = UIColor.systemBlue.cgColor
            drawRect(context: context, center: center, height: CGFloat(note.duration.inTicks.value / 8), color: leftColor)
        }
    }
    
    //MARK: Private func
    private func drawRect(context: CGContext, center: CGPoint, height: CGFloat, color: CGColor) {
        context.setFillColor(color)
        context.beginPath()
        context.addRect(CGRect(x: center.x, y: center.y, width: self.bounds.width / 88, height: height))
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

