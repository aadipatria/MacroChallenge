//
//  BreathView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI
import CoreHaptics


struct BreathView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    @State var index = 0
    @State var inhale: Double = 0
    @State var hold1: Double = 0
    @State var exhale: Double = 0
    @State var hold2: Double = 0
    @State var success : Bool = true
    @State var name : String = ""
    @State var pattern : String = ""
    @State var haptic : Bool = false
    
    @State var animationSets: [AnimationSet] = []
    @State var isBreathing: Bool = false
    @State var breathingState: BreathingState = .none
    
    @State var orbitalEffectScaling: CGFloat = 0.0
    @State var animationSizeScaling: CGFloat = 0.0
    @State var uiElementsOpacityScaling: Double = 1.0
    @State var guidanceTextOpacityScaling: Double = 0.0
    @State var guidanceText: String = ""
    
    @State var startInhale: DispatchWorkItem = DispatchWorkItem {}
    @State var startHold1: DispatchWorkItem = DispatchWorkItem {}
    @State var startExhale: DispatchWorkItem = DispatchWorkItem {}
    @State var startHold2: DispatchWorkItem = DispatchWorkItem {}
    @State var startCompletion: DispatchWorkItem = DispatchWorkItem {}
    @State var engine: CHHapticEngine?
    
    var body: some View {
        VStack {
            // show data by index
            if !breaths.isEmpty{
                HStack {
                    Button(action: {
                        changeLeft()
                    }, label: {
                        Image (systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                    VStack {
                        Text(name)
                        Text(pattern)
                    }.frame(width: ScreenSize.windowWidth() * 0.4)
                    
                    Button(action: {
                        changeRight()
                    }, label: {
                        Image (systemName: "chevron.right")
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    })
                }
                .opacity(self.uiElementsOpacityScaling)
            }
            Group {
                NavigationLink(
                    destination: AfterBreathingView(success: self.success, index: self.index, name: self.name, pattern: self.pattern),
                    isActive : $navPop.toBreathing,
                    label: {
                        EmptyView()
                    })
            }
            .opacity(self.uiElementsOpacityScaling)
            
            Spacer()
            
            ZStack {
                AnimatedRing(binding: self.$orbitalEffectScaling)
                    .padding(30)
                    .scaleEffect(self.animationSizeScaling)
                
                Text(guidanceText)
                    .foregroundColor(Color.white)
                    .opacity(self.guidanceTextOpacityScaling)
            }
            
            Spacer()
            
            Button(action: {
                self.isBreathing.toggle()
                if isBreathing{
                    self.success = true
                    prepareHaptics()
                }else{
                    self.success = false
                    cancelHaptic()
                }
            }) {
                RoundedRectangle(cornerRadius: 10)
            }
            .frame(maxWidth: 200, maxHeight: 80)
            .padding(.bottom, 60)
        }
        .onAppear(perform: {
            let orbitalSet = OrbitalAnimationSet(binding: self.$orbitalEffectScaling).getAnimationSets()
            let textSet = GuidanceTextSet(binding: self.$guidanceText).getAnimationSets()
            self.animationSets = [orbitalSet, textSet]
            
            if !breaths.isEmpty {
                update()
                if navPop.repeatBreath{
                    isBreathing = true
                    navPop.repeatBreath = false
                }
            }
        })
        .onChange(of: breathingState) {newValue in
            switch newValue {
            case .none:
                self.endAction()
            case .inhale:
                self.inhaleAction()
                if haptic{
                    inhale(duration: inhale)
                }
            case .hold1:
                self.hold1Action()
            case .exhale:
                self.exhaleAction()
                if haptic{
                    exhale(duration: exhale)
                }
            case .hold2:
                self.hold2Action()
            }
        }
        .onChange(of: isBreathing, perform: { value in
            if value {
                self.setUpDispatchWorkItems()
                self.startBreathing()
                navPop.tabIsHidden = true
            } else {
                self.stopBreathing()
            }
        })
        .navigationBarHidden(true)
//        .background(Image("ocean").backgroundImageModifier())
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
                        //left
                        if value.translation.width < 0 {
                            changeLeft()
                        }
                        //right
                        if value.translation.width > 0 {
                            changeRight()
                        }
                        
                        
                    }))
    }
    func prepareHaptics(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
            
            
        }catch{
            print("There was an error creating the engine:\(error.localizedDescription)")
        }
    }
}

extension BreathView{
    func changeRight(){
        if !breaths.isEmpty{
            if index == breaths.count - 1 {
                index = 0
            }else{
                index += 1
            }
            update()
        }
    }
    func changeLeft(){
        if !breaths.isEmpty{
            if index == 0 {
                index = breaths.count - 1
            }else{
                index -= 1
            }
            update()
        }
        
    }
    func update(){
        inhale = Double(breaths[index].inhale)
        hold1 = Double(breaths[index].hold1)
        exhale = Double(breaths[index].exhale)
        hold2 = Double(breaths[index].hold2)
        name = String(breaths[index].name!)
        pattern = String(format: "%.0f - %.0f - %.0f - %.0f", self.inhale, self.hold1, self.exhale, self.hold2)
        haptic = Bool(breaths[index].haptic)
    }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        BreathView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
