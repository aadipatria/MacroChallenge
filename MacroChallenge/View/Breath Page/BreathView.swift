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
    @State var audio : Bool = false
    
    let cycleMinutes: [Int] = [1,2,3]
    @State var cycleTime: Int = 0
    @State var cycleRemaining: Int = 0
    
    @State var animationSets: [AnimationSet] = []
    @State var isBreathing: Bool = false
    @State var breathingState: BreathingState = .none
    
    @State var orbitalEffectScaling: CGFloat = 0.0
    @State var animationSizeScaling: CGFloat = 0.0
    @State var uiElementsOpacityScaling: Double = 1.0
    @State var guidanceTextSizeScaling: Double = 0.0
    @State var guidanceTextOpacityScaling: Double = 0.0
    @State var guidanceText: String = ""
    
    @State var startInhale: DispatchWorkItem = DispatchWorkItem {}
    @State var startHold1: DispatchWorkItem = DispatchWorkItem {}
    @State var startExhale: DispatchWorkItem = DispatchWorkItem {}
    @State var startHold2: DispatchWorkItem = DispatchWorkItem {}
    @State var startCompletion: DispatchWorkItem = DispatchWorkItem {}
    @State var engine: CHHapticEngine?
    @State var showStop = false
    
    var body: some View {
        ZStack {
            Group {
                NavigationLink(
                    destination: AfterBreathingView(success: self.success, index: self.index, name: self.name, pattern: self.pattern),
                    isActive : $navPop.toBreathing,
                    label: {
                        EmptyView()
                    })
            }
            //.opacity(self.uiElementsOpacityScaling)
        
            if self.isBreathing {
                VStack {
                    ZStack {
                        AnimatedRing(binding: self.$orbitalEffectScaling)
                            .padding(30)
                            .scaleEffect(self.animationSizeScaling)

                        Text(guidanceText)
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .opacity(self.guidanceTextOpacityScaling)
                    }
                    if showStop{
                        Button(action: {
                            isBreathing = false
                            self.success = false
                            cancelHaptic()
                        }, label: {
                            Image(systemName: "x.circle")
                                .foregroundColor(.white)
                                .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                            
                        })
                    }
                    
                }
            }
            
            HStack(spacing: 16) {
                Button(action: {
                    changeLeft()
                }, label: {
                    Image (systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                })
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.clear)
                    .frame(maxWidth: ScreenSize.windowWidth() * 0.76)
                    .background(
                        Blur(style: .regular)
                            .mask(RoundedRectangle(cornerRadius: 15))
                    )
                
                Button(action: {
                    changeRight()
                }, label: {
                    Image (systemName: "chevron.right")
                        .foregroundColor(.white)
                        .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                })
            }
            .opacity(self.uiElementsOpacityScaling * 0.9)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                            //left
                            if value.translation.width < -40 {
                                changeLeft()
                            }
                            //right
                            if value.translation.width > 40 {
                                changeRight()
                            }


                        }))
            
            VStack(spacing: 8) {
                // show data by index
                if !breaths.isEmpty{
                    Group {
                        Text(name)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Text(pattern)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                        if breaths[index].favorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.black)
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(Color.black)
                        }
                    }.frame(maxWidth: ScreenSize.windowWidth() * 0.6)
                }
                
                ZStack(alignment: .leading) {
                    Text("Minute(s)")
                        .font(.title2)
                        .padding(.leading, 96)
                    
                    Picker(selection: $cycleTime, label: Text("Picker")) {
                        ForEach(cycleMinutes, id: \.self) { minutes in
                            Text("\(minutes)")
                                .font(.title2)
                        }
                    }
                    .frame(width: 160)
                    .clipped()
                }
                
//                Spacer()
                
                Button(action: {
                    self.isBreathing.toggle()
                    if isBreathing{
                        showStop = false
                        self.success = true
                        prepareHaptics()
                        AudioPlayer1.playSounds(soundfile: "nature bgm.mp3")
                        getNumberOfCycles()
                    }else{
                        self.success = false
                        cancelHaptic()
                    }
                }) {
                    Text("Start")
                        .foregroundColor(.black)
                        .frame(width: ScreenSize.windowWidth()*0.5, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
                        .background(RoundedRectangle(cornerRadius: 36).fill(Color(UIColor(.white))))
                }
            }
            .frame(maxWidth: ScreenSize.windowWidth() * 0.72)
            .padding(.vertical, 32)
            .opacity(self.uiElementsOpacityScaling)
            
           
            
//            Spacer()
            
//            Button(action: {
//                self.isBreathing.toggle()
//                if isBreathing{
//                    self.success = true
//                    prepareHaptics()
//                }else{
//                    self.success = false
//                    cancelHaptic()
//                }
//            }) {
//                Text("Start")
//                    .foregroundColor(.black)
//                    .frame(width: ScreenSize.windowWidth()*0.5, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
//                    .background(RoundedRectangle(cornerRadius: 36).fill(Color(UIColor(.white))))
//            }.padding(.bottom, 100)
        }
        .frame(maxHeight: ScreenSize.windowHeight() * 0.52)
        .onAppear(perform: {
            showStop = false
            self.cycleTime = 1
            
            let orbitalSet = OrbitalAnimationSet(binding: self.$orbitalEffectScaling).getAnimationSets()
            let textSet = GuidanceTextSet(binding: self.$guidanceText).getAnimationSets()
            self.animationSets = [orbitalSet, textSet]
            
            if !breaths.isEmpty {
                update()
                if navPop.breathCycles > 0 {
                    isBreathing = true
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
                if audio{
                    AudioPlayer2.playSounds(soundfile: "inhale.mp3")
                }
            case .hold1:
                self.hold1Action()
                if audio{
                    AudioPlayer2.playSounds(soundfile: "hold.mp3")
                }
            case .exhale:
                self.exhaleAction()
                if haptic{
                    exhale(duration: exhale)
                }
                if audio{
                    AudioPlayer2.playSounds(soundfile: "exhale.mp3")
                }
            case .hold2:
                self.hold2Action()
                if audio{
                    AudioPlayer2.playSounds(soundfile: "hold.mp3")
                }
            }
        }
        .onChange(of: isBreathing, perform: { value in
            if value {
                self.setUpDispatchWorkItems()
                self.startBreathing()
                navPop.tabIsHidden = true
            } else {
                self.stopBreathing()
                cancelHaptic()
                AudioPlayer1.stopSounds()
                AudioPlayer2.stopSounds()
            }
        })
        .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
            if isBreathing{
                showStop.toggle()
            }
        })
        .navigationBarHidden(true)
//        .background(Image("ocean").backgroundImageModifier())
//        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                    .onEnded({ value in
//                        //left
//                        if value.translation.width < -20 {
//                            changeLeft()
//                        }
//                        //right
//                        if value.translation.width > 20 {
//                            changeRight()
//                        }
//
//
//                    }))
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
        audio = Bool(breaths[index].sound)
    }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        BreathView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
