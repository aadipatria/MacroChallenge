//
//  AnimationHelper.swift
//  MacroSample
//
//  Created by Aghawidya Adipatria on 21/10/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

class AnimationTimer {
    func performAnimationforBreath(breath: Breathing, animation: [AnimationSet], modifier: Double? = 0.00) {
        var lagModifier: Double = 0.00
        if let timeLag = modifier {
            lagModifier = timeLag
        }
        
        let delayInhale = Double(breath.inhale) - lagModifier
        let delayHold = delayInhale + Double(breath.hold1) - lagModifier
        let delayExhale = delayHold + Double(breath.exhale) - lagModifier
        
        for sets in animation {
            (sets.preInhale ?? {})()
        }
        
        withAnimation(.linear(duration: Double(breath.inhale))) {
            for sets in animation {
                (sets.inhale ?? {})()
            }
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInhale) {
            for sets in animation {
                (sets.preHold1 ?? {})()
            }
            
            withAnimation(.linear(duration: Double(breath.hold1))) {
                for sets in animation {
                    (sets.hold1 ?? {})()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayHold) {
            for sets in animation {
                (sets.preExhale ?? {})()
            }
            
            withAnimation(.linear(duration: Double(breath.exhale))) {
                for sets in animation {
                    (sets.exhale ?? {})()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayExhale) {
            for sets in animation {
                (sets.preHold2 ?? {})()
            }
            
            withAnimation(.linear(duration: Double(breath.hold2))) {
                for sets in animation {
                    (sets.hold2 ?? {})()
                }
            }
        }
    }
}
