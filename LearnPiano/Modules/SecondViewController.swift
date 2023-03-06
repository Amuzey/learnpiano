//
//  SecondViewController.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import Foundation

import UIKit
import AudioKit

class SecondViewController: UIViewController {
    
//    private let conductor = MIDIMonitorConductor()
    private let visualAssistans = VisualAssistans()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>")
        view = visualAssistans
        // Do any additional setup after loading the view.
    }


}
