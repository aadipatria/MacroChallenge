//
//  DonutShape.swift
//  MacroSample
//
//  Created by Aghawidya Adipatria on 28/10/20.
//  Copyright © 2020 Aghawidya Adipatria. All rights reserved.
//

import SwiftUI

struct DonutShape: Shape {
    var size: CGFloat = 0.7
    var delta: CGFloat = 0.25
    
    var animatableData: CGFloat {
        get { delta }
        set { self.delta = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width/2, rect.height/2)
            let deltaDegrees: Angle = .degrees(Double(delta * 360))
            
            path.addRelativeArc(center: center, radius: radius, startAngle: .degrees(270), delta: deltaDegrees)
            path.addRelativeArc(center: center, radius: size * radius, startAngle: .degrees(270) + deltaDegrees, delta: -deltaDegrees)
            
            path.closeSubpath()
        }//.strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
    }
}

struct DonutShape_Preview: PreviewProvider {
    static var previews: some View {
        DonutShape()
    }
}
