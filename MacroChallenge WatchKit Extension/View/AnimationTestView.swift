//
//  AnimationTestView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Aghawidya Adipatria on 10/11/20.
//

import SwiftUI

struct AnimationTestView: View {
    @State var orbitalEffectScaling: CGFloat = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            
            AnimatedRingWatch(binding: self.$orbitalEffectScaling)
            
            Button(action: {
                withAnimation(.linear(duration: 5)) {
                    self.orbitalEffectScaling = 1.0
                }
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.yellow)
                    .frame(maxHeight: WKInterfaceDevice.current().screenBounds.height/8)
            }
        }
        .background(
            Image("ocean")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
    }
}
