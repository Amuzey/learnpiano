//
//  MidiManager.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import Foundation
import MidiParser

class MidiParser {
    let midiName: String
    let midi = MidiData()
    
    init(midiName: String) {
        self.midiName = midiName
        guard let midiFilePath = Bundle.main.path(forResource: midiName, ofType: "mid") else {
            fatalError("MIDI file not found in bundle")
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: midiFilePath)) else {
            fatalError("Failed to load MIDI file data")
        }
        midi.load(data: data)
        
    }
}
