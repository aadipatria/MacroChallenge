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
    
    //fetch semua breathing dari core data -> next step di onAppear
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>

    //ini isinya sama hampir sama dengan yang add new, bedanya hanya di tombol add/savenya + disini ada cek id(UUID) karena mau update
    //kalau ada cara yang lebih bagus ajarin gw - Vincent
    var body: some View {
        VStack {
            EditBreathingCancelAddView(breathName: $breathName, inhale: $inhale, hold1: $hold1, exhale: $exhale, hold2: $hold2, isSoundOn: $isSoundOn, isHapticOn: $isHapticOn, id: id)
            Precautions()
            
            VStack {
                Text("Name")
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
            .frame(width: 375, height: 22, alignment: .leading)
            
            InputName(breathName: $breathName)
            
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
            
            CustomBreathingViewPicker(inhaleSelection: $inhale, hold1Selection: $hold1, exhaleSelection: $exhale, hold2Selection: $hold2)
                .frame(height: 275)
            
            VStack {
                Text("Guiding Preferences")
                    .font(.system(size: 16, weight: .bold, design: .default))
            }
            .frame(width: 375, height: 22, alignment: .leading)
            .padding(.bottom)
            .padding(.top)
            
            GuidingPreferences(isSoundOn: $isSoundOn, isHapticOn: $isHapticOn)
        }
        .padding()
        .onAppear {
            for breath in breaths {
                //basically gw pake predicate ga bisa jadi gw loop manual disini
                //maap agak barbar - Vincent
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


struct EditBreathingCancelAddView: View {
    //bikin 2 ini karena update = fetch -> modif -> save
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
    
    //sama kayak onAppear diatas
    //ambil semua breath -> cari breath yang idnya == id yang di passing kesini -> save
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
                breath.id = self.id
                
                do{
                    try self.manageObjectContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct EditBreathing_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        EditBreathing(id: UUID()).environment(\.managedObjectContext, viewContext)
    }
}

