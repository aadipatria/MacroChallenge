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
    @State var isFavorite = false
    @State var isAlert = false
    @Environment(\.managedObjectContext) var manageObjectContext
    
    //fetch semua breathing dari core data -> next step di onAppear
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>

    //ini isinya sama hampir sama dengan yang add new, bedanya hanya di tombol add/savenya + disini ada cek id(UUID) karena mau update
    //kalau ada cara yang lebih bagus ajarin gw - Vincent
    var body: some View {
        ZStack {
            LoopingPlayer()
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 16) {
                Precautions()
                    .padding(.top)
                InputName(breathName: $breathName)
                
                VStack {
                    Text("Pattern (Seconds)")
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

                
                
                VStack (spacing : 0) {
                    Text("Guiding Preferences")
                        .fontWeight(.semibold)
                        .padding()
                        .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.054, alignment: .leading)
                        .background(SomeBackground.headerBackground())
                        
                    GuidingPreferences(isSoundOn: $isSoundOn, isHapticOn: $isHapticOn)
                        .padding()
                        .background(Rectangle()
                                        .fill(Color.clear)
                                        .background(Blur(style: .systemThinMaterial)
                                                        .opacity(0.95))
                                        .cornerRadius(8, corners: [.bottomLeft, .bottomRight]))
                    
                }
                .frame(width: ScreenSize.windowWidth() * 0.9, alignment: .leading)
                .padding(.top, 8)
                Button(action: {
                    isAlert = true
                }, label: {
                    Text("Delete")
                        .foregroundColor(.white)
                        .modifier(DeleteButtonModifier())
                })
                .alert(isPresented: $isAlert){
                    Alert(title: Text("Delete"), message: Text("Yakin mau dihapus? :)"), primaryButton: .destructive(Text("Delete")) {
                        deleteBreathing()
                        }, secondaryButton: .cancel())
                }
                Spacer()
            }
//            .background(Image("ocean").blurBackgroundImageModifier())
            .navigationBarItems(trailing: EditBreathingCancelAddView(breathName: $breathName, inhale: $inhale, hold1: $hold1, exhale: $exhale, hold2: $hold2, isSoundOn: $isSoundOn, isHapticOn: $isHapticOn, id: id, isFavorite: $isFavorite))
            .frame(width : ScreenSize.windowWidth() * 0.9)
            .navigationBarTitle("Edit Breathing",displayMode: .inline)
            .onAppear {
                checkIdAndChangeData()
        }
        }
    }
}

extension EditBreathing {
    func checkIdAndChangeData() {
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
    func deleteBreathing(){
        for breath in breaths {
            if breath.id == self.id{
                self.manageObjectContext.delete(breath)

                do {
                    try self.manageObjectContext.save()
                } catch {
                    print("error deleting")
                }
            }
        }
        isAlert = false
    }
}


struct EditBreathingCancelAddView: View {
    //bikin 2 ini karena update = fetch -> modif -> save
    @Environment(\.managedObjectContext) var manageObjectContext
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    @EnvironmentObject var navPop : NavigationPopObject
    
    @Binding var breathName : String
    @Binding var inhale : Int
    @Binding var hold1 : Int
    @Binding var exhale : Int
    @Binding var hold2 : Int
    @Binding var isSoundOn : Bool
    @Binding var isHapticOn : Bool
    var id: UUID
    @Binding var isFavorite: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                updateBreath()
                navPop.editBreath = false
            }, label: {
                Text("Save")
            })
        }
    }
}

extension EditBreathingCancelAddView {
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
                breath.favorite = isFavorite
                
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

