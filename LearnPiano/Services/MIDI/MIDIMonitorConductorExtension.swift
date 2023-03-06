////
////  MIDIMonitorConductorExtension.swift
////  LearnPiano
////
////  Created by Алексей on 06.03.2023.
////
//
//import CoreMIDI
//import AudioKit
//
//extension MIDIMonitorConductor: MIDIListener {
//    func receivedMIDINoteOn(noteNumber: MIDINoteNumber,
//                            velocity: MIDIVelocity,
//                            channel: MIDIChannel,
//                            portID _: MIDIUniqueID?,
//                            timeStamp _: MIDITimeStamp?) {
//        instrument.play(noteNumber: noteNumber, velocity: velocity, channel: channel)
//        print(">>>>", noteNumber, velocity, channel)
//        DispatchQueue.main.async {
//            if velocity == 0 {
//                self.data.signalOff?(Int(noteNumber))
//            } else {
//                self.data.signalOn?(Int(noteNumber))
//            }
//            self.data.noteOn = Int(noteNumber)
//            self.data.velocity = Int(velocity)
//            self.data.channel = Int(channel)
//        }
//    }
//
//    func receivedMIDINoteOff(noteNumber: MIDINoteNumber,
//                             velocity _: MIDIVelocity,
//                             channel: MIDIChannel,
//                             portID _: MIDIUniqueID?,
//                             timeStamp _: MIDITimeStamp?) {
//        instrument.stop(noteNumber: noteNumber, channel: channel)
//        DispatchQueue.main.async {
//            self.data.noteOff = Int(noteNumber)
//            self.data.channel = Int(channel)
//        }
//    }
//
//    func receivedMIDIController(_ controller: MIDIByte,
//                                value: MIDIByte,
//                                channel: MIDIChannel,
//                                portID _: MIDIUniqueID?,
//                                timeStamp _: MIDITimeStamp?) {
//        instrument.midiCC(1, value: value, channel: channel)
//        data.controllerNumber = Int(controller)
//        data.controllerValue = Int(value)
//        data.channel = Int(channel)
//    }
//
//    func receivedMIDIAftertouch(_ pressure: MIDIByte,
//                                channel: MIDIChannel,
//                                portID _: MIDIUniqueID?,
//                                timeStamp _: MIDITimeStamp?) {
//        data.afterTouch = Int(pressure)
//        data.channel = Int(channel)
//    }
//
//    func receivedMIDIAftertouch(noteNumber: MIDINoteNumber,
//                                pressure: MIDIByte,
//                                channel: MIDIChannel,
//                                portID _: MIDIUniqueID?,
//                                timeStamp _: MIDITimeStamp?) {
//        data.afterTouchNoteNumber = Int(noteNumber)
//        data.afterTouch = Int(pressure)
//        data.channel = Int(channel)
//    }
//
//    func receivedMIDIPitchWheel(_ pitchWheelValue: MIDIWord,
//                                channel: MIDIChannel,
//                                portID _: MIDIUniqueID?,
//                                timeStamp _: MIDITimeStamp?) {
//        data.pitchWheelValue = Int(pitchWheelValue)
//        data.channel = Int(channel)
//    }
//
//    func receivedMIDIProgramChange(_ program: MIDIByte,
//                                   channel: MIDIChannel,
//                                   portID _: MIDIUniqueID?,
//                                   timeStamp _: MIDITimeStamp?) {
//        data.programChange = Int(program)
//        data.channel = Int(channel)
//    }
//
//    func receivedMIDISystemCommand(_: [MIDIByte],
//                                   portID _: MIDIUniqueID?,
//                                   timeStamp _: MIDITimeStamp?) { }
//
//    func receivedMIDISetupChange() { }
//
//    func receivedMIDIPropertyChange(propertyChangeInfo _: MIDIObjectPropertyChangeNotification) { }
//
//    func receivedMIDINotification(notification _: MIDINotification) { }
//}
