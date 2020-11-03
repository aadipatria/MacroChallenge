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
    
    @State var isAddNewContact : Bool = false
    
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
                
                NavigationLink("Add Contact", destination: AddEmergencyContact())
                    .padding()
                Button(action: {
                    isAddNewContact.toggle()
                    // buat ngilangin tab bar
//                    navPop.tabIsHidden = true
                }, label: {
                    if isAddNewContact{
                        Text("Done")
                    }else{
                        Text("Edit")
                    }
                    
                })
                
                ForEach(self.contacts){ contact in
                    NavigationLink(
                        destination: AddEmergencyContact(), /// harusnya ke edit, pake id biar tau mana yg di edit
                        isActive: $navPop.emergency,
                        label: {
                            EmptyView()
                        })
                    Button(action: {
                        if isAddNewContact{
                            navPop.emergency = true
                        }else{
                            call(number: contact.number!)
                        }
                        
                    }, label: {
                        HStack {
                            if isAddNewContact{
                                Button(action: {
                                    //hapus contact tsb
                                    print("x")
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
                VStack {
                    Text("A")
                }
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
        EmergencyView().environmentObject(NavigationPopObject()).environment(\.managedObjectContext, viewContext)
        
    }
}
