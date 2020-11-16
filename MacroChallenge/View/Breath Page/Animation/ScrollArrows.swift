//
//  ScrollArrows.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 13/11/20.
//

import SwiftUI

struct ScrollArrows: View {
    var arrows: Image = Image(systemName: "chevron.down")
    
    @State var arrow1Opacity: Double = 0.05
    @State var arrow2Opacity: Double = 0.05
    @State var arrow3Opacity: Double = 0.05
    
    @State var animationPhase: Int = 0
    let finalPhase: Int = 5
    
    var body: some View {
        GeometryReader{ geometry in
            VStack(alignment: .center) {
                arrows
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(height: geometry.size.height/3)
                    .offset(x: 0, y: geometry.size.height/12)
                    .opacity(self.arrow1Opacity)
                    .onAnimationCompleted(
                        for: self.arrow1Opacity,
                        completion: {self.changeState()}
                    )
                
                arrows
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(height: geometry.size.height/3)
                    .opacity(self.arrow2Opacity)
                
                arrows
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    //.frame(height: geometry.size.height/3)
                    .offset(x: 0, y: -geometry.size.height/12)
                    .opacity(self.arrow3Opacity)
                
    //            Text("\(self.animationPhase)")
    //            Text("\(self.arrow1Opacity) + \(self.arrow2Opacity) + \(self.arrow3Opacity)")
            }
        }
        .animation(.linear(duration: 0.2))
        .onAppear(perform: {
            self.changeState()
        })
        .onChange(of: self.animationPhase, perform: { value in
            switch value {
            case 0:
                self.arrow1Opacity = 0.05
                self.arrow2Opacity = 0.05
                self.arrow3Opacity = 0.05
            case 1:
                self.arrow1Opacity = 0.5
                self.arrow2Opacity = 0.05
                self.arrow3Opacity = 0.05
            case 2:
                self.arrow1Opacity = 1.0
                self.arrow2Opacity = 0.5
                self.arrow3Opacity = 0.05
            case 3:
                self.arrow1Opacity = 0.55
                self.arrow3Opacity = 1.0
                self.arrow3Opacity = 0.5
            case 4:
                self.arrow1Opacity = 0.05
                self.arrow3Opacity = 0.5
                self.arrow3Opacity = 1.0
            case 5:
                self.arrow1Opacity = 0.045
                self.arrow2Opacity = 0.05
                self.arrow3Opacity = 0.5
            default:
                return
            }
        })
    }
    
    func changeState() {
        if self.animationPhase < self.finalPhase {
            self.animationPhase += 1
        } else {
            self.animationPhase = 0
        }
    }
}

struct ScrollArrowsPreview: PreviewProvider {
    static var previews: some View {
        ScrollArrows()
    }
}
