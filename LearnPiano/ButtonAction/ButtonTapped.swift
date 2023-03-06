//
//  ButtonTapped.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import UIKit

final class TargetAction {
    private let work: () -> Void

    init(_ work: @escaping () -> Void) {
        self.work = work
    }

    @objc func action() {
        work()
    }
}
