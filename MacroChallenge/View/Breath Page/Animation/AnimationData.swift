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
    @Binding var binding: CGFloat
    
    func getAnimationSets() -> AnimationSet {
        return AnimationSet(
            preInhale: {self.binding = 0.0},
            inhale: {self.binding = 1.0},
            preHold1: {self.binding = 0.0},
            hold1: {self.binding = 1.0},
            preExhale: {self.binding = 0.0},
            exhale: {self.binding = 1.0},
            preHold2: {self.binding = 0.0},
            hold2: {self.binding = 1.0}
        )
    }
}
