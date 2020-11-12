//
//  AnimatedRing.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 29/10/20.
//

import SwiftUI

struct AnimatedRing: View {
    @Binding var binding: CGFloat
    var donutRadius: CGFloat = 0.6
    
    var ringColour: Color = Color(UIColor(cgColor: CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)))
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // INNER BLUR
                DonutShape(size: donutRadius, delta: 1.0)
                    .fill(Color.clear)
                    .background(
                        Blur(style: .regular)
                            .mask(DonutShape(size: donutRadius, delta: 1.0))
                    )
                    
                // INNER BLUR PROGRESSION
                DonutShape(size: donutRadius, delta: self.binding)
                    .fill(Color.clear)
                    .background(
                        Blur(style: .regular)
                            .mask(DonutShape(size: donutRadius, delta: self.binding))
                    )
                    
                // OUTER RIM BACKGROUND
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 5))
                    .foregroundColor(ringColour)

                // OUTER RIM
                Circle()
                    .trim(from: 0.0, to: self.binding)
                    .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .butt, lineJoin: .bevel))
                    .fill(Color.white)
                    .rotationEffect(Angle(degrees: 270))

                // HEADER
                Circle()
                    .fill(Color.white)
                    .frame(width: 20, height: 20)
                    .modifier(OrbitalEffect(percent: self.binding, radius: geometry.size.height < geometry.size.width ? geometry.size.height/2 : geometry.size.width/2))
                    
            }
        }
    }
}

//struct AnimatedRing_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimatedRing()
//    }
//}
