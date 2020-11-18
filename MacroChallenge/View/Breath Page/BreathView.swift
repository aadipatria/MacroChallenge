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
    @Environment(\.managedObjectContext) var manageObjectContext
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
    
    @State var breathingStateHelper: BreathingStateHelper = BreathingStateHelper()
    @State var isBreathing: Bool = false
    @State var breathingState: BreathingState = .none
    
    @State var orbitalEffectScaling: CGFloat = 0.0
    @State var animationSizeScaling: CGFloat = 0.0
    @State var uiElementsOpacityScaling: Double = 1.0
    @State var guidanceTextOpacityScaling: Double = 0.0
    @State var guidanceText: String = ""
    @State var engine: CHHapticEngine?
    @State var showStop = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black.opacity(0.001))
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    if isBreathing{
                        showStop.toggle()
                    }
                })
            ZStack {
                Group {
                    NavigationLink(
                        destination: AfterBreathingView(success: self.success, index: self.index, name: self.name, pattern: self.pattern),
                        isActive : $navPop.toBreathing,
                        label: {
                            EmptyView()
                        })
                }
            
                if self.isBreathing {
                    VStack {
                        Spacer()
                        ZStack {
                            AnimatedRing(binding: self.$orbitalEffectScaling)
                                .padding(30)
                                .scaleEffect(self.animationSizeScaling)
                                .onAnimationCompleted(for: self.orbitalEffectScaling, completion: {self.changeState()})

                            Text(guidanceText)
                                .font(Font.custom("Poppins-SemiBold", size: 28, relativeTo: .body))
                                .foregroundColor(Color.white)
                                .opacity(self.guidanceTextOpacityScaling)
                        }
                        Spacer()
                        Button(action: {
                            cancelHaptic()
                            isBreathing = false
                            self.success = false
                            navPop.toBreathing = true
                        }, label: {
                            Text("Stop")
                                .font(Font.custom("Poppins-SemiBold", size: 18, relativeTo: .body))
                                .foregroundColor(.black)
                                .frame(width: ScreenSize.windowWidth()*0.5, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
                                .background(RoundedRectangle(cornerRadius: 36).fill(Color(UIColor(.white))))
                                .opacity(showStop ? 1 : 0)
                            
                        }).disabled(!showStop)
                        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
                        Spacer()
                        
                    }
                }
                
                HStack(spacing: 16) {
                    Button(action: {
                        changeLeft()
                    }, label: {
                        Image (systemName: "chevron.left")
                            .padding(5)
                            .foregroundColor(Color.white)
                            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    })
                    
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.clear)
                        .frame(maxWidth: ScreenSize.windowWidth() * 0.76, maxHeight: 400)
                        .background(
                            Blur(style: .regular)
                                .mask(RoundedRectangle(cornerRadius: 15))
                        )
                    
                    Button(action: {
                        changeRight()
                    }, label: {
                        Image (systemName: "chevron.right")
                            .padding(5)
                            .foregroundColor(Color.white)
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
                                .font(Font.custom("Poppins-Bold", size: 28, relativeTo: .body))
                                .foregroundColor(Color.changeTheme(black: navPop.black))
                            Text(pattern)
                                .fontWeight(.medium)
                                .foregroundColor(Color.changeTheme(black: navPop.black))
                                .font(/*@START_MENU_TOKEN@*/.title3/*@END_MENU_TOKEN@*/)
                            if breaths[index].favorite {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(Color.changeTheme(black: navPop.black))
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
                            } else {
                                Image(systemName: "heart")
                                    .foregroundColor(Color.changeTheme(black: navPop.black))
                                    .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)

                            }
                        }
                    }
                    
                    ZStack(alignment: .leading) {
                        Text("Minute(s)")
                            .font(Font.custom("Poppins-Bold", size: 18, relativeTo: .body))
                            .padding(.leading, 96)
                            .foregroundColor(Color.changeTheme(black: navPop.black))
                        
                        Picker(selection: $cycleTime, label: Text("Picker")) {
                            ForEach(cycleMinutes, id: \.self) { minutes in
                                Text("\(minutes)")
                                    .foregroundColor(Color.changeTheme(black: navPop.black))
                                    .font(Font.custom("Poppins-SemiBold", size: 18, relativeTo: .body))
                            }
                        }
                        .frame(width: 160, height: 150)
                        .clipped()
                    }
                    
                    Button(action: {
                        self.isBreathing.toggle()
                        if isBreathing{
                            showStop = false
                            self.success = true
                            getNumberOfCycles()
                        }else{
                            self.success = false
                            cancelHaptic()
                        }
                    }) {
                        Text("Start")
                            .font(Font.custom("Poppins-SemiBold", size: 18, relativeTo: .body))
                            .foregroundColor(.black)
                            .frame(width: ScreenSize.windowWidth()*0.5, height: ScreenSize.windowHeight() * 0.05, alignment: .center)
                            .background(RoundedRectangle(cornerRadius: 36).fill(Color(UIColor(.white))))
                    }
                }
                .frame(maxWidth: ScreenSize.windowWidth() * 0.72)
//                .padding(.vertical, 32)
                .opacity(self.uiElementsOpacityScaling)
            }
            .frame(maxHeight: ScreenSize.windowHeight() * 0.52)
            .onAppear(perform: {
                prepareHaptics()
                success = true
                showStop = false
                self.cycleTime = 1

                
                if !breaths.isEmpty {
                    update()
                    if navPop.breathCycles > 0 {
                        isBreathing = true
                    }
                }else{
                    var breath = Breathing(context: self.manageObjectContext)
                    breath.name = "Calm"
                    breath.inhale = 4
                    breath.hold1 = 7
                    breath.exhale = 8
                    breath.hold2 = 0
                    breath.favorite = false
                    breath.haptic = true
                    breath.sound = true
                    breath.id = UUID()
                    breath.background = "forest"
                    breath.black = false
                    breath.bgm = true
                    do{
                        //save ke core data
                        try self.manageObjectContext.save()
                    } catch {
                        print(error)
                    }
                    breath = Breathing(context: self.manageObjectContext)
                    breath.name = "Lake Test"
                    breath.inhale = 3
                    breath.hold1 = 3
                    breath.exhale = 5
                    breath.hold2 = 2
                    breath.favorite = true
                    breath.haptic = true
                    breath.sound = true
                    breath.id = UUID()
                    breath.background = "lake"
                    breath.black = true
                    breath.bgm = true
                    do{
                        //save ke core data
                        try self.manageObjectContext.save()
                    } catch {
                        print(error)
                    }
                    update()
                }
                self.breathingStateHelper = BreathingStateHelper(
                    breath: breaths[index],
                    animations: []
                )
                self.updateAnimations()
            })
            .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                if isBreathing{
                    showStop.toggle()
                }
            })
            .onChange(of: breathingState) {newValue in
                switch newValue {
                case .none:
                    breathingStateHelper.startPostBreath()
                case .inhale:
                    breathingStateHelper.startInhale()
                    if haptic{
                        inhale(duration: inhale)
                    }
                case .hold1:
                    breathingStateHelper.startHold1()
                case .exhale:
                    breathingStateHelper.startExhale()
                    if haptic{
                        exhale(duration: exhale)
                    }
                case .hold2:
                    breathingStateHelper.startHold2()
                }
            }
            .onChange(of: isBreathing, perform: { value in
                if value {
                    self.startBreathing()
                    navPop.tabIsHidden = true
                } else {
                    self.stopBreathing()
                }
            })
            .navigationBarHidden(true)

        }
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
        
        if navPop.previous != breaths[index].background{
            navPop.black = Bool(breaths[index].black)
            navPop.playLooping.player.moveBackground(name: breaths[index].background ?? "forest")
            navPop.playLooping2.player.moveBackground(name: breaths[index].background ?? "forest")
            navPop.previous = breaths[index].background ?? "forest"
            breathingStateHelper.updateBackgroundMusic(music: breaths[index].background ?? "forest")
        }
        self.updateAnimations()
    }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        BreathView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
