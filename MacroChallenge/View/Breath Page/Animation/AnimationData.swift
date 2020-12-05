//
//  AnimationData.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 29/10/20.
//

import SwiftUI

struct ScalingAnimationSet {
    @Binding var binding: CGFloat

    func getAnimationSets() -> AnimationSet {
        return AnimationSet(
            inhale: {self.binding *= 2.0},
            exhale: {self.binding /= 2.0}
        )
    }
}

struct OrbitalAnimationSet {
    @Binding var position: CGFloat
    
    func getAnimationSets() -> AnimationSet {
        return AnimationSet(
            preInhale: {self.position = 0.0},
            inhale: {self.position = 0.99},
            preHold1: {self.position = 0},
            hold1: {self.position = 0.99},
            preExhale: {self.position = 0.0},
            exhale: {self.position = 0.99},
            preHold2: {self.position = 0.0},
            hold2: {self.position = 0.99},
            postBreath: {self.position = 0.0}
        )
    }
}

struct GuidanceTextSet {
    @Binding var text: String
    @Binding var opacity: Double
    //var breath: Breathing?
    //var watchBreath: WatchBreathing?
    
    var inhale: Double
    var hold1: Double
    var exhale: Double
    var hold2: Double
    
    init(text: Binding<String>, opacity: Binding<Double>, breath: Breathing) {
        self._text = text
        self._opacity = opacity
        
        self.inhale = Double(breath.inhale)
        self.hold1 = Double(breath.hold1)
        self.exhale = Double(breath.exhale)
        self.hold2 = Double(breath.hold2)
    }
    
    init(text: Binding<String>, opacity: Binding<Double>, breath: WatchBreathing) {
        self._text = text
        self._opacity = opacity
        
        self.inhale = Double(breath.inhale)
        self.hold1 = Double(breath.hold1)
        self.exhale = Double(breath.exhale)
        self.hold2 = Double(breath.hold2)
    }
    
    func getAnimationSets() -> AnimationSet {
        var animations = AnimationSet()
        
        animations.preparation1 = {self.opacity = 1.0}
        
        animations.preparation2 = {
            self.text = "3"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.text = "2"
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.text = "1"
            }
        }
        
        if self.inhale > 0 {
            animations.preInhale = {self.text = "Inhale"}
        }

        if self.hold1 > 0 {
            animations.preHold1 = {self.text = "Hold"}
        }
        
        if self.exhale > 0 {
            animations.preExhale = {self.text = "Exhale"}
        }
        
        if self.hold2 > 0 {
            animations.preHold2 = {self.text = "Hold"}
        }
        
        animations.completion = {
            self.text = ""
            self.opacity = 0.0
        }
        
        return animations
    }
}

struct UIElementsOpacitySet {
    @Binding var opacity: Double
    
    func getAnimationSets() -> AnimationSet {
        var animations = AnimationSet()
        
        animations.preparation1 = {self.opacity = 0.0}
        animations.completion = {self.opacity = 1.0}
        
        return animations
    }
}

struct AnimationSizeSet {
    @Binding var size: CGFloat
    
    func getAnimationSets() -> AnimationSet {
        var animations = AnimationSet()
        
        animations.preparation2 = {self.size = 1.0}
        animations.completion = {self.size = 0.0}
        
        return animations
    }
}
