//
//  AnimationHelper.swift
//  MacroSample
//
//  Created by Aghawidya Adipatria on 21/10/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

extension BreathView {
    
    // MARK: START/STOP BREATHING
    func startBreathing() {
        self.cycleRemaining = navPop.breathCycles
        breathingStateHelper.startPreparation()
        
        let duration = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {self.breathingState = .inhale})
    }
    
    func stopBreathing() {
        self.breathingState = .none
        self.cycleRemaining = 0
        
        cancelHaptic()
        breathingStateHelper.endBreathSession()
    }
    
    // MARK: HELPER FUNCTIONS
    func getNumberOfCycles() {
        let breathingDuration = Int(self.inhale + self.hold1 + self.exhale + self.hold2)
        let numberOfCycles = Int(self.cycleTime * 60 / breathingDuration)
        
//        navPop.breathCycles = self.cycleTime
        navPop.breathCycles = numberOfCycles
    }
    
    func changeState() {
        print(self.breathingState)
        
        switch self.breathingState {
        case .inhale:
            self.breathingState = .hold1
        case .hold1:
            self.breathingState = .exhale
        case .exhale:
            self.breathingState = .hold2
        case .hold2:
            self.breathingState = .none
        case .none:
            self.cycleRemaining -= 1
            
            if self.cycleRemaining > 0 {
                self.breathingState = .inhale
            } else {
                self.isBreathing = false
                navPop.toBreathing = true
            }
        }
    }
    
    func updateAnimations() {
        let orbitalSet = OrbitalAnimationSet(
            position: self.$orbitalEffectScaling
        ).getAnimationSets()
        
        let textSet = GuidanceTextSet(
            text: self.$guidanceText,
            opacity: self.$guidanceTextOpacityScaling,
            breath: breaths[index]
        ).getAnimationSets()
        
        let uiSet = UIElementsOpacitySet(
            opacity: self.$uiElementsOpacityScaling
        ).getAnimationSets()
        
        let animationSet = AnimationSizeSet(
            size: self.$animationSizeScaling
        ).getAnimationSets()
        
        let allSets = [orbitalSet, textSet, uiSet, animationSet]
        
        self.breathingStateHelper.updateStateChanges(animations: allSets)
        self.breathingStateHelper.updateBreathData(breath: breaths[index])
    }
}
