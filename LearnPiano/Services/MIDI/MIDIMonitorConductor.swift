//
//  MIDIMonitorConductor.swift
//  LearnPiano
//
//  Created by Алексей on 06.03.2023.
//

import CoreMIDI
import AudioKit
import AVFAudio
import UIKit
import MidiParser

final class MIDIMonitorConductor: ObservableObject, HasAudioEngine {
    struct Note {
        let track: Int
        let note: Int
        let time: Double
        let duration: Double
        
        var color: UIColor {
            switch track {
            case 0:
                return .yellow
            case 1:
                return .red
            case 2:
                return .green
            case 3:
                return .blue
            default:
                return .black
            }
        }
    }
    private let midi = MIDI()
    let midiParser = MidiData()
    var data = MIDIMonitorData()
    let engine = AudioEngine()
    var instrument = MIDISampler(name: "Instrument 1")
    let sonata = "sonata_dlya_fortepiano_14_-_lunnaya_sonata"
    var playing = true
    var midiPlayer: AVMIDIPlayer?
    var dictionary: [Note] = []

    private func loadInstrument() {
            do {
                if let soundURL = Bundle.main.url(
                    forResource: "Sounds/Sampler Instruments/sawPiano1", withExtension: ".exs") {
                    try instrument.loadInstrument(at: soundURL)
                } else {
                    Log("Could not find file")
                }
            } catch let errors {
                Log(errors.localizedDescription)
            }
            do {
                try engine.start()
            } catch {
                Log("AudioKit did not start!")
            }
    }

//    func play() {
//        let soundPath: String? = Bundle.main.path(
//            forResource: sonata, ofType: "midi")
//        let midiFile: URL = URL(fileURLWithPath: soundPath ?? "")
//        do {
//            let midiParser = MidiData()
//            let data: Data = try Data(contentsOf: midiFile)
//            midiParser.load(data: data)
//            for i in 0..<midiParser.noteTracks.count {
//                let track = midiParser.noteTracks[i]
//                for x in 0..<track.count {
//                    dictionary.append(.init(track: i,
//                                            note: Int(track[x].note),
//                                            time: Double(track[x].timeStamp.inTicks.value),
//                                            duration: Double(track[x].duration.inTicks.value)))
//                    print(track[x].timeStamp.inTicks.value, track[x].timeStamp.inSeconds)
//                }
//            }
//
//        } catch {
//            print("could not create MIDI player")
//        }
//    }
//
//    func playParser() {
//        let midiParser = MidiData()
//        let track1 = midiParser.addTrack()
//        let url: URL = URL(fileURLWithPath: "")
//        DispatchQueue.main.async {
//            do {
//                track1.add(notes: [
//                    MidiNote(regularTimeStamp: 23.83333396911621,
//                                              regularDuration: 0.16666603,
//                                              note: 68,
//                                              velocity: 45,
//                                              channel: 1,
//                                              releaseVelocity: 0,
//                                              beatsPerMinute: BeatsPerMinute(80),
//                                              ticksPerBeat: TicksPerBeat(120)),
//                    MidiNote(regularTimeStamp: 12.0,
//                                              regularDuration: 1.5,
//                                              note: 68,
//                                              velocity: 45,
//                                              channel: 1,
//                                              releaseVelocity: 0,
//                                              beatsPerMinute: BeatsPerMinute(80),
//                                              ticksPerBeat: TicksPerBeat(120)),
//                    MidiNote(regularTimeStamp: 13.5,
//                                              regularDuration: 0.413,
//                                              note: 68,
//                                              velocity: 47,
//                                              channel: 1,
//                                              releaseVelocity: 0,
//                                              beatsPerMinute: BeatsPerMinute(80),
//                                              ticksPerBeat: TicksPerBeat(120)),
//                    MidiNote(regularTimeStamp: 13.916,
//                                              regularDuration: 0.083,
//                                              note: 68,
//                                              velocity: 48,
//                                              channel: 1,
//                                              releaseVelocity: 0,
//                                              beatsPerMinute: BeatsPerMinute(80),
//                                              ticksPerBeat: TicksPerBeat(120)),
//                    MidiNote(regularTimeStamp: 14.0,
//                                              regularDuration: 1.0,
//                                              note: 68,
//                                              velocity: 48,
//                                              channel: 1,
//                                              releaseVelocity: 0,
//                                              beatsPerMinute: BeatsPerMinute(80),
//                                              ticksPerBeat: TicksPerBeat(120))
//                ])
//                track1.patch = MidiPatch(channel: 0, patch: .cello)
//                track1.name = "track1"
//                try? midiParser.writeData(to: url)
//                guard let output = midiParser.createData() else { return }
//                self.midiPlayer = try AVMIDIPlayer(data: output, soundBankURL: nil)
//                self.midiPlayer?.play()
//            } catch {
//                print("kek")
//            }
//        }
//    }

    func stopThis() {
        midiPlayer?.stop()
    }

//    func parse() {
//        DispatchQueue.main.async {
//            let soundPath: String? = Bundle.main.path(
//                forResource: self.sonata, ofType: "midi")
//            let midiFile: URL = URL(fileURLWithPath: soundPath ?? "")
//            do {
//                let data: Data = try Data(contentsOf: midiFile)
//                self.midiParser.load(data: data)
//                let track = self.midiParser.noteTracks[2]
//                print(track[0])
//            } catch let error {
//                print(error)
//            }
//        }
//    }

     init() {
//         play()
         midi.openInput()
         midi.addListener(self)
         engine.output = instrument
         loadInstrument()
//         parse()
     }
 }

//extension Double {
//    static func parse(from string: String) -> Double? {
//        return Double(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
//    }
//}

//extension MidiTime {
//    var inSeconds1: TimeInterval {
//        return inSeconds
//    }
////    let inTicks: Ticks
//}

