//
//  KeyboardButton.swift
//  LearnPiano
//
//  Created by Алексей on 10.03.2023.
//

import UIKit

class KeyboardButton {
    let number: Int
    let frame: CGRect
    var button: UIButton
    var klick: Bool? = false
    
    init(number: Int, frame: CGRect, button: UIButton) {
        self.number = number
        self.frame = frame
        self.button = button
    }
}
