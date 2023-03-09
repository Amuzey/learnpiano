//
//  keyBoardSheme.swift
//  LearnPiano
//
//  Created by Алексей on 08.03.2023.
//

import UIKit

class KeyboardSheme {

    static let shared = KeyboardSheme()
    
    var blackButtons: [Int] = []
    
    func addButtons(buttons: [Int]) {
        self.blackButtons = buttons
    }
}
