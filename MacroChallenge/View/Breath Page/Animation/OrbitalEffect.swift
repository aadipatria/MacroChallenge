//
//  OrbitalEffect.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 29/10/20.
//

import SwiftUI

struct OrbitalEffect: GeometryEffect {
    let initialAngle: CGFloat = CGFloat.pi / -2
    
    var percent: CGFloat = 0
    let radius: CGFloat
    
    var animatableData: CGFloat {
        get { return percent }
        set { percent = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let angle = 2 * CGFloat.pi * percent + initialAngle
        let point = CGPoint(
            x: cos(angle) * radius,
            y: sin(angle) * radius
        )
        
        return ProjectionTransform(CGAffineTransform(translationX: point.x, y: point.y))
    }
}
