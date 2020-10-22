//
//  BreathingModel.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 22/10/20.
//

import Foundation

public class SendBreath {
    var name : String
    var inhale: Int16
    var hold1: Int16
    var exhale: Int16
    var hold2: Int16
    var sound : Bool
    var haptic : Bool
    var id: UUID
    
    init(name: String, inhale: Int16, hold1: Int16, exhale: Int16, hold2: Int16, sound: Bool, haptic: Bool, id: UUID) {
        self.name = name
        self.inhale = inhale
        self.hold1 = hold1
        self.exhale = exhale
        self.hold2 = hold2
        self.sound = sound
        self.haptic = haptic
        self.id = id
    }
}
