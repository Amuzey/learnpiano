//
//  NotesView.swift
//  keyb13
//
//  Created by Артём Коротков on 16.01.2023.
//

import UIKit
import SnapKit

class NotesView: UIView {
    
    override func draw(_ rect: CGRect) {
        let conductor = MIDIMonitorConductor()
        let dictionary = conductor.dictionary
        for x in dictionary {
            setup(x: Double((x.note) * 10), y: x.time / 100, width: 10, height: x.duration / 100, color: x.color)
            print(x)
        }
    }
    
    func setup(x: Double, y: Double, width: Double, height: Double, color: UIColor) {
        let pathRect = CGRect(x: x, y: y, width: width, height: height)
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: 24)

        color.setFill()
        path.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
