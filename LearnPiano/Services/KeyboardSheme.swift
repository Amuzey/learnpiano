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
    
    func click(note: Int) {
        buttons[note - 21].isClicked?.toggle()
    }
}
