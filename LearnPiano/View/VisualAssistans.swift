//
//  VisualAssistans.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import UIKit

class VisualAssistans: UIView {
    
    //MARK: - Private properties
    private var midiManager = MidiManager()
    private var timer: Timer?
    private var yOffset: CGFloat = 0
    private lazy var track = midiManager.midi.noteTracks[1]
    
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
        for note in track {
            let center = CGPoint(x: (Int(note.note) * 15) - 500, y: Int(bounds.height - CGFloat(note.timeStamp.inTicks.value) / 5))
            let circleColor = UIColor.black.cgColor
            drawRect(context: context, center: center, height: CGFloat(note.duration.inTicks.value - 140), color: circleColor)
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
        timer = Timer.scheduledTimer(withTimeInterval: 3/60.0, repeats: true) { [weak self] _ in
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

