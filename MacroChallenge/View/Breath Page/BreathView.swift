//
//  BreathView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

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
                    })
                    VStack {
                        Text(name)
                        Text(pattern)
                    }
                    Button(action: {
                        changeRight()
                    }, label: {
                        Image (systemName: "chevron.right")
                            .foregroundColor(.black)
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
                if isBreathing {
                    self.success = true
                    self.setUpDispatchWorkItems()
                    self.startBreathing()
                } else {
                    self.stopBreathing()
                    self.success = false
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
            }
        })
        .onChange(of: breathingState) {newValue in
            switch newValue {
            case .none:
                self.endAction()
            case .inhale:
                self.inhaleAction()
            case .hold1:
                self.hold1Action()
            case .exhale:
                self.exhaleAction()
            case .hold2:
                self.hold2Action()
            }
        }
//        .onChange(of: isBreathing, perform: { value in
//            if isBreathing {
//                self.success = true
//                self.setUpDispatchWorkItems()
//                self.startBreathing()
//            } else {
//                self.stopBreathing()
//                self.success = false
//            }
//        })
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
}

extension BreathView{
    func changeRight(){
        if index == breaths.count - 1 {
            index = 0
        }else{
            index += 1
        }
        update()
    }
    func changeLeft(){
        if index == 0 {
            index = breaths.count - 1
        }else{
            index -= 1
        }
        update()
    }
    func update(){
        inhale = Double(breaths[index].inhale)
        hold1 = Double(breaths[index].hold1)
        exhale = Double(breaths[index].exhale)
        hold2 = Double(breaths[index].hold2)
        name = String(breaths[index].name!)
        pattern = String(format: "%.0f - %.0f - %.0f - %.0f", self.inhale, self.hold1, self.exhale, self.hold2)
    }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        BreathView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
