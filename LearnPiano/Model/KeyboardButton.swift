//
//  KeyboardButton.swift
//  LearnPiano
//
//  Created by Алексей on 10.03.2023.
//

import UIKit

struct KeyboardButton {
    let number: Int
    let frame: CGRect
    var button: UIButton
    var isClicked: Bool? = false
    var isCorect: Bool? = false
}
