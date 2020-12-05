//
//  AnimatedRingWatch.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Aghawidya Adipatria on 10/11/20.
//

import SwiftUI

struct AnimatedRingWatch: View {
    @Binding var binding: CGFloat
    var donutRadius: CGFloat = 0.6
    
    var ringColour: Color = Color(UIColor(cgColor: CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)))
    
    @State var isProgressBar: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // INNER BLUR
                DonutShape(size: donutRadius, delta: 1.0)
                    .fill(Color.white)
                    .opacity(0.2)
                    
                // INNER BLUR PROGRESSION
                DonutShape(size: donutRadius, delta: self.binding, rounded: isProgressBar)
                    .fill(isProgressBar ? Color.white : Color.gray)
                    .opacity(0.6)
                    .blur(radius: 0.8)
                    
                if !isProgressBar {
                    // OUTER RIM BACKGROUND
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2))
                        .foregroundColor(ringColour)

                    // OUTER RIM
                    Circle()
                        .trim(from: 0.0, to: self.binding)
                        .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .butt, lineJoin: .bevel))
                        .fill(Color.white)
                        .rotationEffect(Angle(degrees: 270))

                    // HEADER
                    Circle()
                        .fill(Color.white)
                        .frame(width: 5, height: 5)
                        .modifier(OrbitalEffect(percent: self.binding, radius: geometry.size.height < geometry.size.width ? geometry.size.height/2 : geometry.size.width/2))
                }
            }
        }
    }
}

//struct AnimatedRingWatch_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimatedRingWatch()
//    }
//}
