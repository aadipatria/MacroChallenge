//
//  WatchBreathExtension.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Aghawidya Adipatria on 18/11/20.
//

import SwiftUI

extension AnimationWatchView {
    
    // MARK: START/STOP BREATHING
    func startBreathing() {
        self.cycleRemaining = navPop.breathCycles
        breathingStateHelper.startPreparation()
        
        let duration = 3.2
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {self.breathingState = .inhale})
    }
    
    func stopBreathing() {
        self.breathingState = .none
        self.cycleRemaining = 0
        
        breathingStateHelper.endBreathSession()
    }
    
    func cancelBreathing() {
        self.cycleRemaining = 0
        breathingStateHelper.endBreathSession()
        
        navPop.breathCycles = 0
        navPop.toAnimation = false
    }
    
    // MARK: HELPER FUNCTIONS
    func getNumberOfCycles() {
        let breathingDuration = self.inhale + self.hold1 + self.exhale + self.hold2
        let numberOfCycles = Int(Double(self.cycleTime * 60) / breathingDuration)
        
//        navPop.breathCycles = self.cycleTime
        navPop.breathCycles = numberOfCycles
//        navPop.breathCycles = 1
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
                self.afterBreathing = true
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
            breath: currentBreath
        ).getAnimationSets()
        
        let uiSet = UIElementsOpacitySet(
            opacity: self.$uiElementsOpacityScaling
        ).getAnimationSets()
        
        let animationSet = AnimationSizeSet(
            size: self.$animationSizeScaling
        ).getAnimationSets()
        
        let allSets = [orbitalSet, textSet, uiSet, animationSet]
        
        self.breathingStateHelper.updateStateChanges(animations: allSets)
        self.breathingStateHelper.updateBreathData(breath: currentBreath)
    }
}
