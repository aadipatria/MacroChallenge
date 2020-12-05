//
//  BreathingStateHelper.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 11/11/20.
//

import SwiftUI

struct BreathingStateHelper {
    var audioGuidance: Bool = false
    
    // MARK: BREATH DATA
    var inhaleDuration: Double = 0
    var hold1Duration: Double = 0
    var exhaleDuration: Double = 0
    var hold2Duration: Double = 0
    
    // MARK: STATE CHANGES
    var preparation1Actions: [() -> ()] = []
    var preparation2Actions: [() -> ()] = []
    var preInhaleActions: [() -> ()] = []
    var inhaleActions: [() -> ()] = []
    var preHold1Actions: [() -> ()] = []
    var hold1Actions: [() -> ()] = []
    var preExhaleActions: [() -> ()] = []
    var exhaleActions: [() -> ()] = []
    var preHold2Actions: [() -> ()] = []
    var hold2Actions: [() -> ()] = []
    var postBreathActions: [() -> ()] = []
    var completionActions: [() -> ()] = []
    
    // MARK: INIT
    init() {}
    
    init(breath: Breathing,animations: [AnimationSet]) {
        self.updateBreathData(breath: breath)
        self.updateStateChanges(animations: animations)
    }
    
    init(breath: WatchBreathing, animations: [AnimationSet]) {
        self.updateBreathData(breath: breath)
        self.updateStateChanges(animations: animations)
    }
    
    // MARK: HELPER FUNCTIONS
    func animationPerState(duration: Double, delay: Double? = 0, instantChanges: [() -> ()], animatedChanges: [() -> ()], completion: (() -> ())? = {}) {
        DispatchQueue.main.async {
            for actions in instantChanges {
                actions()
            }
            
            withAnimation(Animation.linear(duration: duration).delay(delay ?? 0)) {
                for actions in animatedChanges {
                    actions()
                }
            }
        }
    }
    
    // MARK: OTHER METHODS
    mutating func updateBreathData(breath: Breathing) {
        self.inhaleDuration = Double(breath.inhale)
        self.hold1Duration = Double(breath.hold1)
        self.exhaleDuration = Double(breath.exhale)
        self.hold2Duration = Double(breath.hold2)
        
        self.audioGuidance = breath.sound
    }
    
    mutating func updateBreathData(breath: WatchBreathing) {
        self.inhaleDuration = Double(breath.inhale)
        self.hold1Duration = Double(breath.hold1)
        self.exhaleDuration = Double(breath.exhale)
        self.hold2Duration = Double(breath.hold2)
        
        self.audioGuidance = breath.sound
    }
    
    mutating func updateStateChanges(animations: [AnimationSet]) {
        self.preparation1Actions.removeAll()
        self.preparation2Actions.removeAll()
        self.preInhaleActions.removeAll()
        self.inhaleActions.removeAll()
        self.preHold1Actions.removeAll()
        self.hold1Actions.removeAll()
        self.preExhaleActions.removeAll()
        self.exhaleActions.removeAll()
        self.preHold2Actions.removeAll()
        self.hold2Actions.removeAll()
        self.completionActions.removeAll()
        
        for sets in animations {
            if sets.preparation1 != nil {
                self.preparation1Actions.append(sets.preparation1!)
            }
            
            if sets.preparation2 != nil {
                self.preparation2Actions.append(sets.preparation2!)
            }
            
            if sets.preInhale != nil {
                self.preInhaleActions.append(sets.preInhale!)
            }
            
            if sets.inhale != nil {
                self.inhaleActions.append(sets.inhale!)
            }
            
            if sets.preHold1 != nil {
                self.preHold1Actions.append(sets.preHold1!)
            }
            
            if sets.hold1 != nil {
                self.hold1Actions.append(sets.hold1!)
            }
            
            if sets.preExhale != nil {
                self.preExhaleActions.append(sets.preExhale!)
            }
            
            if sets.exhale != nil {
                self.exhaleActions.append(sets.exhale!)
            }
            
            if sets.preHold2 != nil {
                self.preHold2Actions.append(sets.preHold2!)
            }
            
            if sets.hold2 != nil {
                self.hold2Actions.append(sets.hold2!)
            }
            
            if sets.postBreath != nil {
                self.postBreathActions.append(sets.postBreath!)
            }
            
            if sets.completion != nil {
                self.completionActions.append(sets.completion!)
            }
        }
    }
    
    func testCount() {
        print("inhale: \(self.preInhaleActions.count) + \(self.inhaleActions.count)")
        print("hold1: \(self.preHold1Actions.count) + \(self.hold1Actions.count)")
        print("exhale: \(self.preExhaleActions.count) + \(self.exhaleActions.count)")
        print("hold2: \(self.preHold2Actions.count) + \(self.hold2Actions.count)")
    }
}
