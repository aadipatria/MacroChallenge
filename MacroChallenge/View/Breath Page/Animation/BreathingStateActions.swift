//
//  BreathingStateActions.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 11/11/20.
//

import SwiftUI

extension BreathingStateHelper {
    func startInhale() {
        self.animationPerState(
            duration: self.inhaleDuration,
            instantChanges: self.preInhaleActions,
            animatedChanges: self.inhaleActions
        )
        
        if audioGuidance {
            AudioPlayer2.playSounds(soundfile: "inhale.mp3")
        }
    }
    
    func startHold1() {
        self.animationPerState(
            duration: self.hold1Duration,
            instantChanges: self.preHold1Actions,
            animatedChanges: self.hold1Actions
        )
        
        if audioGuidance && hold1Duration > 0 {
            AudioPlayer2.playSounds(soundfile: "hold.mp3")
        }
    }
    
    func startExhale() {
        self.animationPerState(
            duration: self.exhaleDuration,
            instantChanges: self.preExhaleActions,
            animatedChanges: self.exhaleActions
        )
        
        if audioGuidance {
            AudioPlayer2.playSounds(soundfile: "exhale.mp3")
        }
    }
    
    func startHold2() {
        self.animationPerState(
            duration: self.hold2Duration,
            instantChanges: self.preHold2Actions,
            animatedChanges: self.hold2Actions
        )
        
        if audioGuidance && hold1Duration > 0 {
            AudioPlayer2.playSounds(soundfile: "hold.mp3")
        }
    }
    
    func startPreparation() {
        let duration1: Double = 0.2
        let duration2: Double = 3
        
        self.animationPerState(
            duration: duration1,
            instantChanges: [],
            animatedChanges: self.preparation1Actions
        )
        
        self.animationPerState(
            duration: duration2,
            delay: duration1,
            instantChanges: [],
            animatedChanges: self.preparation2Actions
        )
        
        AudioPlayer1.playSounds(soundfile: "\(backgroundMusic).mp3")
    }
    
    func startPostBreath() {
        self.animationPerState(
            duration: 0,
            instantChanges: [],
            animatedChanges: self.postBreathActions
        )
    }
    
    func endBreathSession() {
        self.animationPerState(
            duration: 0,
            instantChanges: [],
            animatedChanges: self.completionActions
        )
        
        AudioPlayer1.stopSounds()
        AudioPlayer2.stopSounds()
    }
}
