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
        
        for note in track {
            print("\(note)\n")
        }
        print(track[1])
        print(track[2])
        print(track[50])
        print(track[80])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycles
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        for note in track {
            let center = CGPoint(x: (Int(note.note) * 15) - 500, y: Int(note.timeStamp.inTicks.value)/20)
            let radius = 5.0
            let circleColor = UIColor.black.cgColor
            drawCircle(context: context, center: center, radius: radius, color: circleColor)
        }
    }
    
    //MARK: Private func
    private func drawCircle(context: CGContext, center: CGPoint, radius: CGFloat, color: CGColor) {
        context.setFillColor(color)
        context.beginPath()
        context.addArc(center: center, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
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

