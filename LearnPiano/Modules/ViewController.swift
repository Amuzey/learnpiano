//
//  ViewController.swift
//  LearnPiano
//
//  Created by Alexey Nikiforov on 20.01.2023.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
//    private let conductor = MIDIMonitorConductor()
    
    private let visualAssistans = VisualAssistans()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(">>>")
        view = visualAssistans
        // Do any additional setup after loading the view.
    }


}

