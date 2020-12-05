////
////  StartAnimationWatchView.swift
////  MacroChallenge WatchKit Extension
////
////  Created by Aghawidya Adipatria on 10/11/20.
////
//
//import SwiftUI
//
//struct StartAnimationWatchView: View {
//    @EnvironmentObject var navPop: NavigationWatchPopObject
//    @State var currentBreath: WatchBreathing = WatchBreathing()
//
//    @State var name : String = "Calm"
//    @State var inhale : Double = 4
//    @State var hold1 : Double = 7
//    @State var exhale : Double = 8
//    @State var hold2 : Double = 0
//    @State var haptic : Bool = false
//    @State var sound : Bool = true
//
//    let cycleMinutes: [Int] = [1,2,3]
//    @State var cycleTime: Int = 0
//    @State var cycleRemaining: Int = 0
//
//    @State var breathingStateHelper: BreathingStateHelper = BreathingStateHelper()
//    @State var isBreathing: Bool = false
//    @State var breathingState: BreathingState = .none
//
//    @State var orbitalEffectScaling: CGFloat = 0.0
//    @State var animationSizeScaling: CGFloat = 0.0
//    @State var uiElementsOpacityScaling: Double = 1.0
//    @State var guidanceTextOpacityScaling: Double = 0.0
//    @State var guidanceText: String = ""
//
//    @State var success: Bool = false
//    @State var showStop: Bool = false
//
//    var body: some View {
//        ZStack {
////            NavigationLink(
////                destination: AfterBreathingWatchView().environmentObject(navPop),
////                isActive : $navPop.afterBreathing,
////                label: {
////                    EmptyView()
////                }
////            ).animation(nil)
//
//            AnimatedRingWatch(binding: self.$orbitalEffectScaling)
//                .padding(8)
//                .scaleEffect(animationSizeScaling)
//                //.onAnimationCompleted(for: self.orbitalEffectScaling, completion: {self.changeState()})
//
//            Text(guidanceText)
//                .opacity(guidanceTextOpacityScaling)
//
//            Button(action: {
//                self.isBreathing.toggle()
//                if isBreathing{
//                    self.showStop = false
//                    self.success = true
//                    //self.getNumberOfCycles()
//                }else{
//                    self.success = false
//                }
//            }) {
//                RoundedRectangle(cornerRadius: 25)
//                    .foregroundColor(Color.yellow)
//                    //.frame(maxHeight: ScreenSize.windowHeight()/4)
//                    .frame(maxWidth: 98, maxHeight: 28)
//            }
//            .opacity(uiElementsOpacityScaling)
//            .disabled(uiElementsOpacityScaling >= 1.0 ? false : true)
//        }
//        .background(
//            Image("ocean")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//        )
//        .onAppear(perform: {
//            success = true
//            showStop = false
//            self.cycleTime = 1
//
////            currentBreath = WatchBreathing()
//            currentBreath.name = self.name
//            currentBreath.inhale = self.inhale
//            currentBreath.hold1 = self.hold1
//            currentBreath.exhale = self.exhale
//            currentBreath.hold2 = self.hold2
//            currentBreath.haptic = self.haptic
//            currentBreath.sound = self.sound
//
//            self.breathingStateHelper = BreathingStateHelper(
//                breath: currentBreath,
//                animations: []
//            )
//
//            //self.updateAnimations()
//        })
//        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
//            if isBreathing{
//                showStop.toggle()
//            }
//        })
//        .onChange(of: breathingState) {newValue in
//            switch newValue {
//            case .none:
//                breathingStateHelper.startPostBreath()
//            case .inhale:
//                breathingStateHelper.startInhale()
//            case .hold1:
//                breathingStateHelper.startHold1()
//            case .exhale:
//                breathingStateHelper.startExhale()
//            case .hold2:
//                breathingStateHelper.startHold2()
//            }
//        }
//        .onChange(of: isBreathing, perform: { value in
//            if value {
//                //self.startBreathing()
//            } else {
//                //self.stopBreathing()
//            }
//        })
//    }
//}
//
//struct StartAnimationTestView_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimationWatchView(inhale: 2, hold1: 0, exhale: 2, hold2: 0, haptic: false, sound: true).environmentObject(NavigationWatchPopObject())
//    }
//}
