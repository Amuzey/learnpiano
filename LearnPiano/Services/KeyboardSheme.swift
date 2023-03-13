//
//  keyBoardSheme.swift
//  LearnPiano
//
//  Created by Алексей on 08.03.2023.
//

import UIKit

class KeyboardSheme {
    static let shared = KeyboardSheme()
    var buttons: [KeyboardButton] = []
    
    func saveButtons(buttons: [KeyboardButton]) {
        self.buttons = buttons
    }
    
    func klick(note: Int) {
        buttons[note].klick?.toggle()
    }
}
