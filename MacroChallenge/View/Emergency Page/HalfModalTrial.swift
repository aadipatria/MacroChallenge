//
//  HalfModalTrial.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 16/11/20.
//

import SwiftUI

struct HalfModalTrial: View {
    
    @State var isModalSHown = false
    
    var body: some View {
        ZStack {
            Button(action: {
                self.isModalSHown = true
            }, label: {
                Text("Show Modal")
            })
            
            if isModalSHown {
                AddContactModal(isAddNewContact: $isModalSHown)
            }
        }
    }
}

struct AddContactModal: View {
    @EnvironmentObject var navPop : NavigationPopObject
    let modalHeight: CGFloat = 400
    @Binding var isAddNewContact: Bool
    @State var off: CGFloat = 200
    
    var body: some View {
        
        ZStack {
            BackgroundView()
                .onTapGesture {
                    self.off = 200
                    self.isAddNewContact = false
                    navPop.tabIsHidden = false
                    hideKeyboard()
                }
            VStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - modalHeight - 50)
                ZStack {
                    Color.white.opacity(1)
                    Blur(style: .systemThinMaterial).opacity(0.95)
                    AddEmergencyContact(isAddNewContact: $isAddNewContact)
                        .padding(.bottom, 180)
                }
                .frame(width: UIScreen.main.bounds.width, height: modalHeight)
                .offset(y: off)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.off = 0
                    }
                }
                .cornerRadius(15, corners: [.topLeft, .topRight])
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            if value.translation.height > 0 {
                                self.off = value.translation.height
                            }
                        })
                        .onEnded({ (value) in
                            if value.translation.height > 250 {
                                self.isAddNewContact = false
                                navPop.tabIsHidden = false
                                hideKeyboard()
                            }
                            else {
                                self.off = 0
                            }
                        })
                )
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .animation(.interpolatingSpring(stiffness: 300, damping: 30))
        }
    }
}

struct EditContactModal: View {
    @EnvironmentObject var navPop : NavigationPopObject
    let modalHeight: CGFloat = 400
    @Binding var isContactEdited: Bool
    @State var off: CGFloat = 200
    
    @Binding var name: String
    @Binding var number: String
    @Binding var id: UUID
    
    var body: some View {
        ZStack {
            BackgroundView()
                .onTapGesture {
                    self.off = 200
                    self.isContactEdited = false
                    navPop.tabIsHidden = false
                    hideKeyboard()
                }
            VStack {
                Spacer()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - modalHeight - 50)
                ZStack {
                    Color.white.opacity(1)
                    Blur(style: .systemThinMaterial).opacity(0.95)
                    EditEmergencyContact(name: self.$name, number: self.$number, id: self.id, contactEdited: self.$isContactEdited)
                        .padding(.bottom, 180)
                }
                .cornerRadius(15, corners: [.topLeft, .topRight])
                .frame(width: UIScreen.main.bounds.width, height: modalHeight)
                .offset(y: off)
                .onAppear() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.off = 0
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged({ (value) in
                            if value.translation.height > 0 {
                                self.off = value.translation.height
                            }
                        })
                        .onEnded({ (value) in
                            if value.translation.height > 250 {
                                self.isContactEdited = false
                                navPop.tabIsHidden = false
                                hideKeyboard()
                            }
                            else {
                                self.off = 0
                            }
                        })
                )
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .animation(.interpolatingSpring(stiffness: 300, damping: 30))
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        Color.black
            .opacity(0.8)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct HalfModalTrial_Previews: PreviewProvider {
    static var previews: some View {
        HalfModalTrial()
    }
}
