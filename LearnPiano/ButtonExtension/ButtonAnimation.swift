//
//  Button++.swift
//  keyb13
//
//  Created by Артём Коротков on 07.01.2023.
//

import UIKit

extension UIButton {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .allowUserInteraction,
                       animations: {
            self.transform = .identity
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }
}
