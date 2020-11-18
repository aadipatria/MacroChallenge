//
//  CustomBreathingView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.

import SwiftUI
import CoreData

//var playLooping = LoopingPlayer()

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
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var navPop : NavigationPopObject
    @State var attempts: Int = 0
    
    //fetch semua breathing dari core data -> next step di onAppear
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>

    //ini isinya sama hampir sama dengan yang add new, bedanya hanya di tombol add/savenya + disini ada cek id(UUID) karena mau update
    //kalau ada cara yang lebih bagus ajarin gw - Vincent
    var body: some View {
        ZStack {
            navPop.playLooping
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 16) {
                HStack{
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .padding(8)
                    })
                    Spacer()
                    Text("Edit Breathing")
                        .font(Font.custom("Poppins-SemiBold", size: 18, relativeTo: .body))
                        .foregroundColor(Color.changeTheme(black: navPop.black))
                    Spacer()
                    Button(action: {
                        if breathName == ""{
                            withAnimation(.default) {
                                self.attempts += 1
                            }
                        }else{
                            updateBreath()
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }, label: {
                        Text("Save")
                            .foregroundColor(self.breathName == "" ? Color.gray : Color.changeTheme(black: navPop.black))
                    })
                }.padding(.top)
                Precautions()
                    .padding(.top)
                InputName(breathName: $breathName)
                    .modifier(Shake(animatableData: CGFloat(attempts)))
                
                VStack {
                    Text("Pattern - in seconds")
                        .font(Font.custom("Poppins-SemiBold", size: 16, relativeTo: .body))
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
                                    .font(Font.custom("Poppins-Light", size: 15, relativeTo: .body))
                                    .frame(width: ScreenSize.windowWidth() * 0.2075)
                                Text("Hold")
                                    .font(Font.custom("Poppins-Light", size: 15, relativeTo: .body))
                                    .frame(width: ScreenSize.windowWidth() * 0.2075)
                                Text("Exhale")
                                    .font(Font.custom("Poppins-Light", size: 15, relativeTo: .body))
                                    .frame(width: ScreenSize.windowWidth() * 0.2075)
                                Text("Hold")
                                    .font(Font.custom("Poppins-Light", size: 15, relativeTo: .body))
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
                        .font(Font.custom("Poppins-SemiBold", size: 16, relativeTo: .body))
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
                Button(action: {
                    isAlert = true
                }, label: {
                    Text("Delete")
                        .foregroundColor(.white)
                        .modifier(DeleteButtonModifier())
                })
                .alert(isPresented: $isAlert){
                    Alert(title: Text("Are you sure you want to delete  \(breathName)?"), primaryButton: .destructive(Text("Delete")) {
                        deleteBreathing()
                        }, secondaryButton: .cancel())
                }
                Spacer()
            }
//            .background(Image("ocean").blurBackgroundImageModifier())
            .frame(width : ScreenSize.windowWidth() * 0.9)
            .navigationBarHidden(true)
            .onAppear {
                checkIdAndChangeData()
        }
        }
        .onTapGesture {
            hideKeyboard()
        }   .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            navPop.playLooping.player.playing()
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
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
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
                    self.presentationMode.wrappedValue.dismiss()
                } catch {
                    print(error)
                }
            }
        }
    }
}


//struct EditBreathingCancelAddView: View {
//    //bikin 2 ini karena update = fetch -> modif -> save
//    @Environment(\.managedObjectContext) var manageObjectContext
//    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
//    @EnvironmentObject var navPop : NavigationPopObject
//    @Environment(\.presentationMode) var presentationMode
//
//    @Binding var breathName : String
//    @Binding var inhale : Int
//    @Binding var hold1 : Int
//    @Binding var exhale : Int
//    @Binding var hold2 : Int
//    @Binding var isSoundOn : Bool
//    @Binding var isHapticOn : Bool
//    var id: UUID
//
//    var body: some View {
//        HStack {
//            Spacer()
//            Button(action: {
//                updateBreath()
//                self.presentationMode.wrappedValue.dismiss()
//            }, label: {
//                Text("Save")
//                    .foregroundColor(self.breathName == "" ? Color.gray : Color.white)
//            })
//            .disabled(self.breathName == "" ? true : false)
//        }
//    }
//}

//extension EditBreathingCancelAddView {
//    //sama kayak onAppear diatas
//    //ambil semua breath -> cari breath yang idnya == id yang di passing kesini -> save
//    func updateBreath() {
//        for breath in breaths {
//            if breath.id == self.id {
//                breath.name = breathName
//                breath.inhale = Int16(inhale)
//                breath.hold1 = Int16(hold1)
//                breath.exhale = Int16(exhale)
//                breath.hold2 = Int16(hold2)
//                breath.sound = isSoundOn
//                breath.haptic = isHapticOn
//                breath.id = self.id
//
//                do{
//                    try self.manageObjectContext.save()
//                    self.presentationMode.wrappedValue.dismiss()
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
//}

struct EditBreathing_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        EditBreathing(id: UUID()).environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}

