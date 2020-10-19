//
//  CustomBreathingView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.

import SwiftUI
import CoreData

struct EditBreathing: View {
    @State var breathName = ""
    @State var inhale = 0
    @State var hold1 = 0
    @State var exhale = 0
    @State var hold2 = 0
    @State var isSoundOn = false
    @State var isHapticOn = false
    var id: UUID
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>

    var body: some View {
        VStack {
            EditBreathingCancelAddView(breathName: $breathName, inhale: $inhale, hold1: $hold1, exhale: $exhale, hold2: $hold2, isSoundOn: $isSoundOn, isHapticOn: $isHapticOn, id: id)
            Precautions()
            
            VStack {
                Text("Name")
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
            .frame(width: 375, height: 22, alignment: .leading)
            
            EditBreathingInputName(breathName: $breathName)
            
            VStack {
                Text("Pattern")
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
            .frame(width: 375, height: 22, alignment: .leading)
            .padding(.bottom)
            .padding(.top)

            HStack {
                Text("Inhale")
                    .frame(width: 375/4)
                Text("Hold")
                    .frame(width: 375/4)
                Text("Exhale")
                    .frame(width: 375/4)
                Text("Hold")
                    .frame(width: 375/4)
            }
            
            EditBreathingCustomBreathingViewPicker(inhaleSelection: $inhale, hold1Selection: $hold1, exhaleSelection: $exhale, hold2Selection: $hold2)
                .frame(height: 275)
            
            VStack {
                Text("Guiding Preferences")
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
            .frame(width: 375, height: 22, alignment: .leading)
            .padding(.bottom)
            .padding(.top)
            
            EditBreathingGuidingPreferences(isSoundOn: $isSoundOn, isHapticOn: $isHapticOn)
        }
        .padding()
        .onAppear {
            for breath in breaths {
                if breath.id == self.id {
                    self.breathName = breath.name!
                    self.inhale = Int(breath.inhale)
                    self.hold1 = Int(breath.hold1)
                    self.exhale = Int(breath.exhale)
                    self.hold2 = Int(breath.hold2)
                    self.isSoundOn = breath.sound
                    self.isHapticOn = breath.haptic
                }
            }
        }
    }
}

struct EditBreathingGuidingPreferences: View {
    @Binding var isSoundOn : Bool
    @Binding var isHapticOn : Bool
    var body: some View {
        VStack{
            Toggle(isOn: $isSoundOn, label: {
                Text("Sound")
            })
            .padding(.leading)
            .padding(.trailing)
            
            Toggle(isOn: $isHapticOn, label: {
                Text("Haptic")
            })
            .padding(.leading)
            .padding(.trailing)
        }
    }
}

struct EditBreathingInputName: View {
    @Binding var breathName : String
    var body: some View {
        VStack {
            ZStack{
                TextField("NAME", text: $breathName)
                    .frame(width: 311, height: 44)
                    .multilineTextAlignment(.center)
                HStack {
                    Spacer()
                    Button(action: {
                        self.breathName = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .frame(width: 15, height: 22)
                            .foregroundColor(.gray)
                    })
                }
            }
            .padding(.horizontal, 50)
            Rectangle()
                .frame(width: 311, height: 1, alignment: .center)
                .foregroundColor(.gray)
        }
    }
}

struct EditBreathingCustomBreathingViewPicker: View {
    
    @Binding var inhaleSelection : Int
    @Binding var hold1Selection : Int
    @Binding var exhaleSelection : Int
    @Binding var hold2Selection : Int
    
    var inhale = [Int](0..<11)
    var hold1 = [Int](0..<11)
    var exhale = [Int](0..<11)
    var hold2 = [Int](0..<11)
    
    var body: some View {
        HStack {
            Picker("", selection: self.$inhaleSelection) {
                ForEach(0..<self.inhale.count) { index in
                    Text("\(self.inhale[index])").tag(index)
                }
            }
            .frame(width: 375/4, height: 250, alignment: .center)
            .clipped()
            
            Picker("", selection: self.$hold1Selection) {
                ForEach(0..<self.hold1.count) { index in
                    Text("\(self.hold1[index])").tag(index)
                }
            }
            .frame(width: 375/4, height: 250, alignment: .center)
            .clipped()
            
            Picker("", selection: self.$exhaleSelection) {
                ForEach(0..<self.exhale.count) { index in
                    Text("\(self.exhale[index])").tag(index)
                }
            }
            .frame(width: 375/4, height: 250, alignment: .center)
            .clipped()
            
            Picker("", selection: self.$hold2Selection) {
                ForEach(0..<self.hold2.count) { index in
                    Text("\(self.hold2[index])").tag(index)
                }
            }
            .frame(width: 375/4, height: 250, alignment: .center)
            .clipped()
        }
    }
}

struct EditBreathingCancelAddView: View {
    @Environment(\.managedObjectContext) var manageObjectContext
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    
    @Binding var breathName : String
    @Binding var inhale : Int
    @Binding var hold1 : Int
    @Binding var exhale : Int
    @Binding var hold2 : Int
    @Binding var isSoundOn : Bool
    @Binding var isHapticOn : Bool
    var id: UUID
    
    var body: some View {
        HStack {
            Text("Cancel")
            Spacer()
            Button(action: {
                updateBreath()
            }, label: {
                Text("Save")
            })
        }
        .padding()
    }
    
    func updateBreath() {
        for breath in breaths {
            if breath.id == self.id {
                breath.name = breathName
                breath.inhale = Int16(inhale)
                breath.hold1 = Int16(hold1)
                breath.exhale = Int16(exhale)
                breath.hold2 = Int16(hold2)
                breath.sound = isSoundOn
                breath.haptic = isHapticOn
                breath.id = UUID()
                
                do{
                    try self.manageObjectContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

//struct EditBreathing_Previews: PreviewProvider {
//    static var previews: some View {
//        EditBreathing()
//    }
//}

