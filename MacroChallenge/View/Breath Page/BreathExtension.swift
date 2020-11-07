//
//  AnimationHelper.swift
//  MacroSample
//
//  Created by Aghawidya Adipatria on 21/10/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

extension BreathView {
    
    // MARK: GUIDING ACTIONS PER STATE
    func inhaleAction() {
        var preInhale: [() -> ()] = []
        var inhale: [() -> ()] = []
        
        for sets in animationSets {
            if sets.preInhale != nil {
                preInhale.append(sets.preInhale!)
            }

            if sets.inhale != nil {
                inhale.append(sets.inhale!)
            }
        }
        
        self.animationPerState(duration: self.inhale, instantChanges: preInhale, animatedChanges: inhale)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.inhale, execute: self.startHold1)
    }

    func hold1Action() {
        var preHold1: [() -> ()] = []
        var hold1: [() -> ()] = []
        
        for sets in animationSets {
            if sets.preHold1 != nil {
                preHold1.append(sets.preHold1!)
            }

            if sets.hold1 != nil {
                hold1.append(sets.hold1!)
            }
        }
        
        self.animationPerState(duration: self.hold1, instantChanges: preHold1, animatedChanges: hold1)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.hold1, execute: self.startExhale)
    }

    func exhaleAction() {
        var preExhale: [() -> ()] = []
        var exhale: [() -> ()] = []
        
        for sets in animationSets {
            if sets.preExhale != nil {
                preExhale.append(sets.preExhale!)
            }

            if sets.exhale != nil {
                exhale.append(sets.exhale!)
            }
        }
        
        self.animationPerState(duration: self.exhale, instantChanges: preExhale, animatedChanges: exhale)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.exhale, execute: self.startHold2)
    }

    func hold2Action() {
        var preHold2: [() -> ()] = []
        var hold2: [() -> ()] = []
        
        for sets in animationSets {
            if sets.preHold2 != nil {
                preHold2.append(sets.preHold2!)
            }

            if sets.hold2 != nil {
                hold2.append(sets.hold2!)
            }
        }
        
        self.animationPerState(duration: self.hold2, instantChanges: preHold2, animatedChanges: hold2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + self.hold2, execute: self.startCompletion)
    }
    
    func endAction() {
        var completion: [() -> ()] = []
        
        for sets in animationSets {
            if sets.completion != nil {
                completion.append(sets.completion!)
            }
        }
        
        self.animationPerState(duration: 0, instantChanges: [], animatedChanges: completion)
        
        self.isBreathing = false
        self.adjustBreathingUIElements()
        navPop.toBreathing = true
    }
    
    // MARK: START/STOP BREATHING
    func startBreathing() {
        let duration = 2.0
//        self.breathingState = .inhale
        self.adjustBreathingUIElements(duration: duration)
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: self.startInhale)
    }
    
    func stopBreathing() {
        self.breathingState = .none
        
        self.startInhale.cancel()
        self.startHold1.cancel()
        self.startExhale.cancel()
        self.startHold2.cancel()
        self.startCompletion.cancel()
        
        self.adjustBreathingUIElements()
        
    }
    
    // MARK: HELPER FUNCTIONS
    func animationPerState(duration: Double, instantChanges: [() -> ()], animatedChanges: [() -> ()], completion: (() -> ())? = {}) {
        DispatchQueue.main.async {
            for actions in instantChanges {
                actions()
            }
            
            withAnimation(.linear(duration: duration)) {
                for actions in animatedChanges {
                    actions()
                }
            }
        }
        
        if completion != nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                if self.isBreathing {
                    completion!()
                }
            }
        }
    }
    
    func setUpDispatchWorkItems() {
        // remember to check strong references
        self.startInhale = DispatchWorkItem {self.breathingState = .inhale}
        self.startHold1 = DispatchWorkItem {self.breathingState = .hold1}
        self.startExhale = DispatchWorkItem {self.breathingState = .exhale}
        self.startHold2 = DispatchWorkItem {self.breathingState = .hold2}
        self.startCompletion = DispatchWorkItem {self.breathingState = .none}
    }
    
    func adjustBreathingUIElements(duration: Double? = 0.0) {
        if self.isBreathing {
            withAnimation(.linear(duration: (duration ?? 0)/2)) {
                self.uiElementsOpacityScaling = 0.0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (duration ?? 0)/2) {
                withAnimation(.linear(duration: (duration ?? 0)/2)) {
                    self.guidanceTextOpacityScaling = 1.0
                    self.animationSizeScaling = 1.0
                }
            }
        } else {
            self.uiElementsOpacityScaling = 1.0
            self.guidanceTextOpacityScaling = 0.0
            self.animationSizeScaling = 0.0
        }
    }
}
