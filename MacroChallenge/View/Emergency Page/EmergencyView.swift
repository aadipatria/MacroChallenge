//
//  ContentView.swift
//  testingCallFile
//
//  Created by Yudis Huang on 05/10/20.
//  Copyright © 2020 Yudis Huang. All rights reserved.
//

import SwiftUI

struct EmergencyView: View {
    @EnvironmentObject var navPop : NavigationPopObject
    
    @FetchRequest(fetchRequest: Emergency.getAllEmergency()) var contacts: FetchedResults<Emergency>
    @Environment(\.managedObjectContext) var manageObjectContext
    
    @State var isAddNewContact: Bool = false
    @State var isEdited: Bool = false
    
    @State var id: UUID
    
    let sendWatchHelper = WatchHelper()
    
    @State var contact2DArray = [[String]]()
    
    var body: some View {
        ZStack {
            VStack{
                Button {
                    sync()
                } label: {
                    Text("Sync With Apple Watch")
                }
                Button(action: {
                    isAddNewContact.toggle()
                    // buat ngilangin tab bar
                    navPop.tabIsHidden = true
                }, label: {
                    Text("Add New Contact")
                        .padding()
                })
                
                ForEach(self.contacts){ contact in
                    Button(action: {
                        if isAddNewContact{
                            navPop.emergency = true
                            navPop.tabIsHidden = true
                            self.id = contact.id
                        }else{
                            call(number: contact.number!)
                        }
                        
                    }, label: {
                        HStack {
                            if isAddNewContact{
                                Button(action: {
                                    self.manageObjectContext.delete(contact)
                                    
                                    do {
                                        try self.manageObjectContext.save()
                                    } catch {
                                        print("error deleting")
                                    }
                                }, label: {
                                    Image(systemName: "x.circle")
                                })
                            }
                            VStack {
                                Text("\(contact.name!)")
                                Text("\(contact.number!)")
                            }
                            Spacer()
                            if !isAddNewContact{
                                Button(action: {
                                    call(number: contact.number!)
                                }, label: {
                                    Image(systemName: "phone.fill")
                                })
                            }
                            
                        }
                        .animation(.easeIn(duration: 0.6))
                        .padding()
                        .frame(width: ScreenSize.windowWidth() * 0.9, height: ScreenSize.windowHeight() * 0.1)
                        .background(Rectangle()
                                        .fill(Color.clear)
                                        .background(Blur(style: .systemThinMaterial)
                                                        .opacity(0.95))
                                        .cornerRadius(8))
                    })
                }
                Spacer()
            }
            .background(Image("ocean").backgroundImageModifier())
            
            HalfModalView(isShown: $isAddNewContact) {
                AddEmergencyContact(isAddNewContact: $isAddNewContact)
            }
            
            HalfModalView(isShown: $isEdited) {
                EditEmergencyContact(id: self.id, isEdited: $isEdited)
            }
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
        for contact in self.contacts {
            var contactArray = [String]()
            contactArray.append(contact.id.uuidString)
            contactArray.append(contact.name!)
            contactArray.append(contact.number!)
            contact2DArray.append(contactArray)
        }
        
        print(contact2DArray[0][1])
        
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
        EmergencyView(id: UUID()).environmentObject(NavigationPopObject()).environment(\.managedObjectContext, viewContext)
        
    }
}
