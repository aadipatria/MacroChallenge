//
//  CustomBreathingView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.

import SwiftUI

struct CustomBreathingView: View {
    
    @State var breathName = ""
    @State var inhale = 0
    @State var hold1 = 0
    @State var exhale = 0
    @State var hold2 = 0
    @State var isSoundOn = false
    @State var isHapticOn = false
    @State var isFavorite = false
    
    init() {
        UINavigationBar.appearance().barTintColor = .clear
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().standardAppearance.shadowColor = .clear
//        UINavigationBar.appearance().scrollEdgeAppearance?.shadowColor = .clear
    }
    
    var body: some View {
        VStack {
            Precautions()
            InputName(breathName: $breathName)
            VStack {
                Group {
                    ZStack {
                        SomeBackground.headerBackground()
                        Text("Pattern (Seconds)")
                            .padding()
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.054, alignment: .leading)
                    }
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .background(Blur(style: .systemThinMaterial)
                                            .opacity(0.95))
                            .cornerRadius(8, corners: [.bottomLeft, .bottomRight])
                        VStack {
                            HStack {
                                Text("Inhale")
                                    .frame(width: ScreenSize.windowWidth() * 0.2075)
                                Text("Hold")
                                    .frame(width: ScreenSize.windowWidth() * 0.2075)
                                Text("Exhale")
                                    .frame(width: ScreenSize.windowWidth() * 0.2075)
                                Text("Hold")
                                    .frame(width: ScreenSize.windowWidth() * 0.2075)
                            }.padding(.top)
                            CustomBreathingViewPicker(inhaleSelection: $inhale, hold1Selection: $hold1, exhaleSelection: $exhale, hold2Selection: $hold2)
                                .frame(height: (226-40))
                        }
                    }
                    .frame(height: (215))
                }
                
            }
            .padding(.vertical)
            
            
            
            VStack {
                Text("Guiding Preferences")
                    .padding()
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .frame(width: ScreenSize.windowWidth() * 0.9, height: 28, alignment: .leading)
                    .background(SomeBackground.headerBackground())
                    .padding(.top)
                    
                GuidingPreferences(isSoundOn: $isSoundOn, isHapticOn: $isHapticOn, isFavorite: $isFavorite)
                    .padding()
                    .background(Rectangle()
                                    .fill(Color.clear)
                                    .background(Blur(style: .systemThinMaterial)
                                                    .opacity(0.95))
                                    .cornerRadius(8, corners: [.bottomLeft, .bottomRight]))
                
            }
            .frame(width: ScreenSize.windowWidth() * 0.9, alignment: .leading)
            
            
            
        }
        .background(Image("ocean").blurBackgroundImageModifier())
        .navigationBarItems(trailing: CancelAddView(breathName: $breathName, inhale: $inhale, hold1: $hold1, exhale: $exhale, hold2: $hold2, isSoundOn: $isSoundOn, isHapticOn: $isHapticOn, isFavorite: $isFavorite))
        .frame(width : ScreenSize.windowWidth() * 0.9)
        .navigationBarTitle("Add Breathing",displayMode: .inline)
    }
}

struct Precautions: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.clear)
                .background(Blur(style: .systemThinMaterial)
                                .opacity(0.95))
                .cornerRadius(8)
                .frame(width: ScreenSize.windowWidth() * 0.87, height: ScreenSize.windowHeight() * 0.135)
            VStack(alignment: .leading) {
                Text("Precautions:")
                    .font(.system(size: 16, weight: .semibold, design: .default))
                Group {
                    Text("- Make sure that the breathing pattern is as")
                    Text("suggested as the experts")
                    Text("- It is better when the exhale is longer than the")
                    Text("inhale period")
                }
                .font(.system(size: 12, weight: .regular, design: .default))
            }
        }
    }
}

struct InputName: View {
    @Binding var breathName : String
    var body: some View {
        VStack {
            ZStack{
                Rectangle()
                    .fill(Color.clear)
                    .background(Blur(style: .systemThinMaterial)
                                    .opacity(0.95))
                    .cornerRadius(8)
                    .frame(width: ScreenSize.windowWidth() * 0.87, height: ScreenSize.windowHeight() * 0.074)
                HStack {
                    TextField("Name", text: $breathName)
                        .frame(width: ScreenSize.windowWidth() * 0.8, height: ScreenSize.windowHeight() * 0.05)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                }
                HStack {
                    Spacer()
                    Button(action: {
                        self.breathName = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .padding()
                    })
                }
            }
            Rectangle()
                .frame(width: ScreenSize.windowWidth() * 0.83, height: 0.5, alignment: .center)
                .foregroundColor(.gray)
                .padding(.vertical, -ScreenSize.windowWidth() * 0.04)
        }
    }
}



//Multi-Component picker, namanya doang keren isinya hanya Hstack + picker biasa
struct CustomBreathingViewPicker: View {
    @Binding var inhaleSelection : Int
    @Binding var hold1Selection : Int
    @Binding var exhaleSelection : Int
    @Binding var hold2Selection : Int
    
    var inhale = [Int](0..<11)
    var hold1 = [Int](0..<11)
    var exhale = [Int](0..<11)
    var hold2 = [Int](0..<11)
    
    var body: some View {
        ZStack {
                HStack {
                Picker("", selection: self.$inhaleSelection) {
                    ForEach(0..<self.inhale.count) { index in
                        Text("\(self.inhale[index])").tag(index)
                    }
                }
                .frame(width: ScreenSize.windowWidth() * 0.2075, height: ScreenSize.windowHeight() * 0.185, alignment: .center)
                .clipped()
                
                Picker("", selection: self.$hold1Selection) {
                    ForEach(0..<self.hold1.count) { index in
                        Text("\(self.hold1[index])").tag(index)
                    }
                }
                .frame(width: ScreenSize.windowWidth() * 0.2075, height: ScreenSize.windowHeight() * 0.185, alignment: .center)
                .clipped()
                
                Picker("", selection: self.$exhaleSelection) {
                    ForEach(0..<self.exhale.count) { index in
                        Text("\(self.exhale[index])").tag(index)
                    }
                }
                .frame(width: ScreenSize.windowWidth() * 0.2075, height: ScreenSize.windowHeight() * 0.185, alignment: .center)
                .clipped()
                
                Picker("", selection: self.$hold2Selection) {
                    ForEach(0..<self.hold2.count) { index in
                        Text("\(self.hold2[index])").tag(index)
                    }
                }
                .frame(width: ScreenSize.windowWidth() * 0.2075, height: ScreenSize.windowHeight() * 0.185, alignment: .center)
                .clipped()
            }
        }
    }
}

struct GuidingPreferences: View {
    @Binding var isSoundOn: Bool
    @Binding var isHapticOn: Bool
    @Binding var isFavorite: Bool
    var body: some View {
        VStack{
            Toggle(isOn: $isSoundOn, label: {
                Text("Sound")
            })
            .padding(.horizontal)
            
            Toggle(isOn: $isHapticOn, label: {
                Text("Haptic")
            })
            .padding(.horizontal)
            
            Toggle(isOn: $isFavorite) {
                Text("Favorite")
            }
            .padding(.horizontal)
        }
        
    }
}



struct CancelAddView: View {
    //pake ini untuk save ke core data
    @Environment(\.managedObjectContext) var manageObjectContext
    @EnvironmentObject var navPop : NavigationPopObject
    
    @Binding var breathName : String
    @Binding var inhale : Int
    @Binding var hold1 : Int
    @Binding var exhale : Int
    @Binding var hold2 : Int
    @Binding var isSoundOn : Bool
    @Binding var isHapticOn : Bool
    @Binding var isFavorite : Bool
    
    var body: some View {
        Button(action: {
            saveToCoreData()
            navPop.addBreath = false
            
        }, label: {
            Text("Add")
        })
    }
}

extension CancelAddView {
    func saveToCoreData() {
        let breath = Breathing(context: self.manageObjectContext)
        breath.name = breathName
        breath.inhale = Int16(inhale)
        breath.hold1 = Int16(hold1)
        breath.exhale = Int16(exhale)
        breath.hold2 = Int16(hold2)
        breath.sound = isSoundOn
        breath.haptic = isHapticOn
        breath.id = UUID()
        breath.favorite = isFavorite
        
        do{
            //save ke core data
            try self.manageObjectContext.save()
        } catch {
            print(error)
        }
    }
}
struct CustomBreathingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBreathingView().environmentObject(NavigationPopObject())
    }
}
