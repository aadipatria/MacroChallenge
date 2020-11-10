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
        ZStack {
//            LoopingPlayer()
//                .edgesIgnoringSafeArea(.all)
            VStack (spacing : 16) {
                Precautions()
                    .padding(.top)
                InputName(breathName: $breathName)
                VStack {
                    Group {
                        Text("Pattern - in seconds")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.054, alignment: .leading)
                            .background(SomeBackground.headerBackground())
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
                VStack (spacing : 0) {
                    Text("Guiding Preferences")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.054, alignment: .leading)
                        .background(SomeBackground.headerBackground())
                        
                    GuidingPreferences(isSoundOn: $isSoundOn, isHapticOn: $isHapticOn)
                        .padding(.vertical)
                        .background(Rectangle()
                                        .fill(Color.clear)
                                        .background(Blur(style: .systemThinMaterial)
                                                        .opacity(0.95))
                                        .cornerRadius(8, corners: [.bottomLeft, .bottomRight]))
                    
                }
                .frame(width: ScreenSize.windowWidth() * 0.9, alignment: .leading)
                .padding(.top, 8)
                Spacer()
            }
//            .background(Image("ocean").blurBackgroundImageModifier())
            .background(LoopingPlayer()
                            .frame(width: ScreenSize.windowWidth(), height: ScreenSize.windowHeight(), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .ignoresSafeArea(.all))
            .navigationBarItems(trailing: CancelAddView(breathName: $breathName, inhale: $inhale, hold1: $hold1, exhale: $exhale, hold2: $hold2, isSoundOn: $isSoundOn, isHapticOn: $isHapticOn))
            .frame(width : ScreenSize.windowWidth() * 0.9)
            .navigationBarTitle("Add Breathing",displayMode: .inline)
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
}

extension CustomBreathingView {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.135)
            VStack(alignment: .leading) {
                Text("Precautions:")
                    .font(.headline)
                    .fontWeight(.semibold)
                Group {
                    Text("- Make sure that the breathing pattern is as suggested by the doctor or psychiatrist")
                        .font(.footnote)
                    Text("- Try to make the exhale period longer than the inhale period")
                        .font(.footnote)
                }
                .font(.system(size: 12, weight: .regular, design: .default))
            }
            .frame(width: ScreenSize.windowWidth() * 0.75, height: ScreenSize.windowHeight() * 0.135)
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
                    .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.074)
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
                Rectangle()
                    .frame(width: ScreenSize.windowWidth() * 0.8, height: 0.5, alignment: .center)
                    .foregroundColor(.gray)
                    .padding(.top,ScreenSize.windowHeight() * 0.057 )
            }
        }
    }
}



//Multi-Component picker, namanya doang keren isinya hanya Hstack + picker biasa
struct CustomBreathingViewPicker: View {
    @Binding var inhaleSelection : Int
    @Binding var hold1Selection : Int
    @Binding var exhaleSelection : Int
    @Binding var hold2Selection : Int
    
    //batasnya ganti disni
    var inhale = [Int](2..<11)
    var hold1 = [Int](0..<11)
    var exhale = [Int](2..<11)
    var hold2 = [Int](0..<11)
    
    var body: some View {
        ZStack {
                HStack {
                Picker("", selection: self.$inhaleSelection) {
                    ForEach(self.inhale, id: \.self) { index in
                        Text("\(index)").tag(index)
                    }
                }
                .frame(width: ScreenSize.windowWidth() * 0.2075, height: ScreenSize.windowHeight() * 0.185, alignment: .center)
                .clipped()
                
                Picker("", selection: self.$hold1Selection) {
                    ForEach(self.hold1, id: \.self) { index in
                        Text("\(index)").tag(index)
                    }
                }
                .frame(width: ScreenSize.windowWidth() * 0.2075, height: ScreenSize.windowHeight() * 0.185, alignment: .center)
                .clipped()
                
                Picker("", selection: self.$exhaleSelection) {
                    ForEach(self.exhale, id: \.self) { index in
                        Text("\(index)").tag(index)
                    }
                }
                .frame(width: ScreenSize.windowWidth() * 0.2075, height: ScreenSize.windowHeight() * 0.185, alignment: .center)
                .clipped()
                
                Picker("", selection: self.$hold2Selection) {
                    ForEach(self.hold2, id: \.self) { index in
                        Text("\(index)").tag(index)
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
    var body: some View {
        VStack{
            Toggle(isOn: $isSoundOn, label: {
                Text("Audio Instruction")
            })
            .padding(.horizontal)
            
            Toggle(isOn: $isHapticOn, label: {
                Text("Haptic")
            })
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
