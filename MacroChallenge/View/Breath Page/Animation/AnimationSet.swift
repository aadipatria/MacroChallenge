//
//  AnimationSet.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 29/10/20.
//

import Foundation

struct AnimationSet {
    var preparation1: (() -> Void)?
    var preparation2: (() -> Void)?
    
    var preInhale: (() -> Void)?
    var inhale: (() -> Void)?
    var preHold1: (() -> Void)?
    var hold1: (() -> Void)?
    var preExhale: (() -> Void)?
    var exhale: (() -> Void)?
    var preHold2: (() -> Void)?
    var hold2: (() -> Void)?
    
    var postBreath: (() -> Void)?
    var completion: (() -> Void)?
}
