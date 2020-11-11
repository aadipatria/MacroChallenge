//
//  ContentView.swift
//  testingCallFile
//
//  Created by Yudis Huang on 05/10/20.
//  Copyright © 2020 Yudis Huang. All rights reserved.
//

import SwiftUI
import Combine

struct EmergencyView: View {
    @EnvironmentObject var navPop : NavigationPopObject

    @FetchRequest(fetchRequest: Emergency.getAllEmergency()) var contacts: FetchedResults<Emergency>
    @Environment(\.managedObjectContext) var manageObjectContext
    @State var isAlert : Bool = false
    
    @State private var keyboardHeight: CGFloat = 0

    @State var isAddNewContact: Bool = false
    @State var contactEdited: Bool = false
    
    @State var isEdited: Bool = false

    @State var id: UUID = UUID()
    @State var name: String = ""
    @State var number: String = ""

    let sendWatchHelper = WatchHelper()

    @State var contact2DArray = [[String]]()
    
    var body: some View {
        ZStack() {
            VStack(spacing: 0){
                HStack {
                    Text("Top Contacts")
                        .font(Font.custom("Poppins-Bold", size: 24, relativeTo: .body))
                        .foregroundColor(.white)
                    Spacer()
                    if !contacts.isEmpty{
                        Button(action: {
                            isEdited.toggle()
                        }, label: {
                            if isEdited{
                                Text("Done")
                                    .font(Font.custom("Poppins-SemiBold", size: 13, relativeTo: .body))
                                    .foregroundColor(.black)
                                    .background(SomeBackground.editBackground())
                                    .padding(.horizontal)
                            }else{
                                Text("Edit")
                                    .font(Font.custom("Poppins-SemiBold", size: 13, relativeTo: .body))
                                    .foregroundColor(.black)
                                    .background(SomeBackground.editBackground())
                                    .padding(.horizontal)
                            }

                        })
                    }
                    
                    if !isEdited && contacts.count < 3 || contacts.isEmpty{
                        ZStack {
                            SomeBackground.plusBackground()
                            Button(action: {
                                self.isAddNewContact = true
                                navPop.tabIsHidden = true
                            }, label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            })

                        }
                    }
                }
                .frame(width : ScreenSize.windowWidth() * 0.9, height : ScreenSize.windowHeight() * 0.05)
                .animation(.easeInOut(duration: 0.6))
                .padding(.bottom)
                
                Button {
                    sync()
                } label: {
                    Text("Sync With Apple Watch")
                }
                .disabled(self.contacts.isEmpty ? true : false)
                
                if contacts.isEmpty{
                    Text("You have no contact. Tap on the “+” button to add a contact.")
                        .font(Font.custom("Poppins-Medium", size: 18, relativeTo: .body))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(width : ScreenSize.windowWidth() * 0.5)
                        .padding()
                }else{
                    ForEach(self.contacts){ contact in
                        Button(action: {
                            if isEdited{
                                navPop.emergency = true
                                navPop.tabIsHidden = true
                                
                                self.id = contact.id
                                self.name = contact.name!
                                self.number = contact.number!
                                
                                
                                //pake ini biar textfieldnya udh ada isinya waktu modal dipanggil
                                //entah knp harus diginiin baru bisa
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    self.contactEdited = true
                                }
                            }else{
                                call(number: contact.number!)
                            }

                        }, label: {
                            HStack {
                                if isEdited{
                                    Button(action: {
                                        isAlert = true
                                    }, label: {
                                        Image(systemName: "x.circle.fill")
                                            .foregroundColor(.red)
                                            .padding(10)
                                    })
                                    .alert(isPresented: $isAlert){
                                        Alert(title: Text("Are you sure you want to delete this contact?"), primaryButton: .destructive(Text("Delete")) {
                                            self.manageObjectContext.delete(contact)
                                            do {
                                                try self.manageObjectContext.save()
                                            } catch {
                                                print("error deleting")
                                            }
                                            }, secondaryButton: .cancel())
                                    }
                                }
                                VStack(alignment : .leading, spacing : 4) {
                                    Text("\(contact.name!)")
                                        .font(Font.custom("Poppins-SemiBold", size: 16, relativeTo: .body))
                                        .foregroundColor(.black)
                                    Text("\(contact.number!)")
                                        .font(Font.custom("Poppins-Regular", size: 14, relativeTo: .body))
                                        .foregroundColor(.black)
                                }.padding()
                                Spacer()
                                if !isEdited{
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20))
                                        .padding()
                                }else{
                                    Image(systemName: "square.and.pencil")
                                        .foregroundColor(.black)
                                        .font(.system(size: 20))
                                        .padding()
                                }

                            }
                            .animation(.easeInOut(duration: 0.6))
                            .padding()
                            .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.1)
                            .background(Rectangle()
                                            .fill(Color.clear)
                                            .background(Blur(style: .systemThinMaterial)
                                                            .opacity(0.95))
                                            .cornerRadius(8))
                        })
                    }
                    .padding(.bottom, 16)
                }
                
                Spacer()
            }
//            .background(Image("ocean").backgroundImageModifier())
            .frame(width: ScreenSize.windowWidth() * 0.9)

            HalfModalView(isShown: $isAddNewContact) {
                AddEmergencyContact(isAddNewContact: $isAddNewContact)
            }

            HalfModalView(isShown: $contactEdited) {
                EditEmergencyContact(name: self.$name, number: self.$number, id: self.id, contactEdited: self.$contactEdited)
            }
        }
        .padding(.bottom, keyboardHeight - 45)
        .onReceive(Publishers.keyboardHeight) {
            self.keyboardHeight = $0
        }
    }
}

extension EmergencyView{
    func call(number : String){
        guard let phoneNumber =  number as String?, let url = URL(string:"telprompt://\(phoneNumber)") else {
            return
        }
        
        UIApplication.shared.open(url)
    }
    
    func sync() {
        contact2DArray.removeAll()
        for contact in self.contacts {
            var contactArray = [String]()
            contactArray.append(contact.id.uuidString)
            contactArray.append(contact.name!)
            contactArray.append(contact.number!)
            contact2DArray.append(contactArray)
        }
        sendWatchHelper.sendArrayOfContact(contact: contact2DArray)
    }
    
    func deleteItem(indexSet: IndexSet) {
        let deleteItem = self.contacts[indexSet.first!]
        self.manageObjectContext.delete(deleteItem)
        
        do {
            try self.manageObjectContext.save()
        } catch {
            print("error deleting")
        }
    }
}

struct EmergencyView_Previews: PreviewProvider {

    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        EmergencyView().environmentObject(NavigationPopObject()).environment(\.managedObjectContext, viewContext)

    }
}
