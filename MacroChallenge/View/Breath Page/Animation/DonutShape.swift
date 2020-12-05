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
    var rounded: Bool = false
    
    var animatableData: CGFloat {
        get { delta }
        set { self.delta = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width/2, rect.height/2)
            let deltaDegrees: Angle = .degrees(Double(delta * 360))
        
            let capRadius = radius * (1 - size) / 2
            let coordinateOffset = radius * size + capRadius
            let roundedOffset = CGFloat(0)
            
            path.addRelativeArc(center: center, radius: radius, startAngle: .degrees(270), delta: deltaDegrees)
            
            if rounded {
                let finalEndPoint = CGPoint(
                    x: center.x + cos((delta + 0.75) * CGFloat.pi * 2) * coordinateOffset,
                    y: center.y + sin((delta + 0.75) * CGFloat.pi * 2) * coordinateOffset)
                
                path.addRelativeArc(
                    center: finalEndPoint,
                    radius: capRadius,
                    startAngle: .degrees(270 + Double(delta) * 360),
                    delta: .degrees(180))
            }
            
            path.addRelativeArc(center: center, radius: size * radius, startAngle: .degrees(270) + deltaDegrees, delta: -deltaDegrees)
            
            if rounded {
                let startEndPoint = CGPoint(
                    x: center.x + roundedOffset,
                    y: center.y - coordinateOffset)
                
                path.addRelativeArc(
                    center: startEndPoint,
                    radius: capRadius,
                    startAngle: .degrees(90),
                    delta: .degrees(180))
            }
            
            //path.closeSubpath()
        }//.strokedPath(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
    }
}

struct DonutShape_Preview: PreviewProvider {
    static var previews: some View {
        DonutShape()
    }
}
