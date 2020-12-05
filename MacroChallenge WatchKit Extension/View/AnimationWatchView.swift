//
//  AnimationWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Aghawidya Adipatria on 10/11/20.
//

import SwiftUI

struct AnimationWatchView: View {
    @EnvironmentObject var navPop: NavigationWatchPopObject
    @State var currentBreath: WatchBreathing = WatchBreathing()
    @State var tabSelection: Int = 0
    @Namespace var animatedRing
    
    @State var name : String = "Calm"
    @State var inhale : Double = 4
    @State var hold1 : Double = 7
    @State var exhale : Double = 8
    @State var hold2 : Double = 0
    @State var haptic : Bool = false
    @State var sound : Bool = true
    
    @State var cycleTime: Int = 1
    @State var cycleRemaining: Int = 0
    
    @State var breathingStateHelper: BreathingStateHelper = BreathingStateHelper()
    @State var isBreathing: Bool = false
    @State var breathingState: BreathingState = .none
    @State var afterBreathing: Bool = false
    
    @State var orbitalEffectScaling: CGFloat = 0.0
    @State var animationSizeScaling: CGFloat = 0.0
    @State var uiElementsOpacityScaling: Double = 1.0
    @State var guidanceTextOpacityScaling: Double = 0.0
    @State var guidanceText: String = ""
    
    var body: some View {
        ZStack {
            AnimatedRingWatch(binding: self.$orbitalEffectScaling)
                .matchedGeometryEffect(id: "ring", in: animatedRing)
                .padding(8)
                .scaleEffect(animationSizeScaling)
                .matchedGeometryEffect(id: "size", in: animatedRing)
                .onAnimationCompleted(for: self.orbitalEffectScaling, completion: {self.changeState()})
            
            Text(guidanceText)
                .font(.system(size: 14, weight: .bold, design: .default))
                .animation(nil)
                .opacity(guidanceTextOpacityScaling)
            
            if !isBreathing {
                CycleSelectionView(
                    cycleTime: $cycleTime,
                    buttonAction: {
                        self.getNumberOfCycles()
                        withAnimation(Animation.linear(duration: 0.2)) {
                            self.isBreathing = true
                        }
                    })
            }
            
            if isBreathing {
                TabView(selection: self.$tabSelection) {
                    ZStack {
                        AnimatedRingWatch(binding: self.$orbitalEffectScaling)
                            .matchedGeometryEffect(id: "ring", in: animatedRing)
                            .padding(8)
                            .scaleEffect(animationSizeScaling)
                            .matchedGeometryEffect(id: "size", in: animatedRing)
                        
                        Text(guidanceText)
                            .font(.system(size: 14, weight: .bold, design: .default))
                            .animation(nil)
                    }
                    .background(
                        Image("ocean")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    )
                    .tag(0)
                    
                    StopAnimationWatchView(
                        stopAction: {self.cancelBreathing()}
                    )
                        .tag(1)
                }
            }
            
            if afterBreathing {
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.bottom)
                    
                    AfterBreathingWatchView(
                        isBreathing: self.$isBreathing,
                        afterBreathing: self.$afterBreathing)
                }
            }
        }
        .background(
            Image("ocean")
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .onAppear(perform: {
            //self.cycleTime = 1

            currentBreath.name = self.name
            currentBreath.inhale = self.inhale
            currentBreath.hold1 = self.hold1
            currentBreath.exhale = self.exhale
            currentBreath.hold2 = self.hold2
            currentBreath.haptic = self.haptic
            currentBreath.sound = self.sound
            
            self.breathingStateHelper = BreathingStateHelper(
                breath: currentBreath,
                animations: []
            )
            
            self.updateAnimations()
        })
        .onChange(of: breathingState) {newValue in
            switch newValue {
            case .none:
                breathingStateHelper.startPostBreath()
            case .inhale:
                breathingStateHelper.startInhale()
            case .hold1:
                breathingStateHelper.startHold1()
            case .exhale:
                breathingStateHelper.startExhale()
            case .hold2:
                breathingStateHelper.startHold2()
            }
        }
        .onChange(of: isBreathing, perform: { value in
            if value {
                self.startBreathing()
            } else {
                self.stopBreathing()
            }
        })
    }
}

struct AnimationTestView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationWatchView(inhale: 2, hold1: 0, exhale: 2, hold2: 0, haptic: false, sound: true).environmentObject(NavigationWatchPopObject())
    }
}
