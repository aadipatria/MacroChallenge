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
    
    @State var isEdited : Bool = false
    
    let sendWatchHelper = WatchHelper()
    
    @State var contact2DArray = [[String]]()
    
    var body: some View {
        ZStack {
            VStack{
                HStack {
                    Text("Top Contacts")
                        .font(.title)
                        .frame(height: ScreenSize.windowHeight() * (40/812))
                        .padding()
                    Spacer()
                    Button(action: {
                        isEdited.toggle()
                        // buat ngilangin tab bar
    //                    navPop.tabIsHidden = true
                    }, label: {
                        if isEdited{
                            Text("Done")
                                .padding()
                                .background(SomeBackground.editBackground())
                        }else{
                            Text("Edit")
                                .padding()
                                .background(SomeBackground.editBackground())
                        }

                    })
                    if !isEdited {
                        ZStack {
                            SomeBackground.plusBackground()
                            NavigationLink(
                                destination: AddEmergencyContact(),
                                isActive : $navPop.halfModal,
                                label: {
                                    EmptyView()
                                })
                            Button(action: {
                                navPop.halfModal = true
                            }, label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                            })
                            
                        }
                    }
                }.animation(.easeInOut(duration: 0.6))
                .frame(width : ScreenSize.windowWidth() * 0.9)
                Button {
                    sync()
                } label: {
                    Text("Sync With Apple Watch")
                }
                
                ForEach(self.contacts){ contact in
                    NavigationLink(
                        destination: AddEmergencyContact(), /// harusnya ke edit, pake id biar tau mana yg di edit
                        isActive: $navPop.emergency,
                        label: {
                            EmptyView()
                        })
                    Button(action: {
                        if isEdited{
                            navPop.emergency = true
                        }else{
                            call(number: contact.number!)
                        }
                        
                    }, label: {
                        HStack {
                            if isEdited{
                                Button(action: {
                                    self.manageObjectContext.delete(contact)
                                    
                                    do {
                                        try self.manageObjectContext.save()
                                    } catch {
                                        print("error deleting")
                                    }
                                }, label: {
                                    Image(systemName: "x.circle")
                                        .padding()
                                })
                            }
                            VStack {
                                Text("\(contact.name!)")
                                Text("\(contact.number!)")
                            }
                            Spacer()
                            if !isEdited{
                                Button(action: {
                                    call(number: contact.number!)
                                }, label: {
                                    Image(systemName: "phone.fill")
                                })
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
                .padding(.bottom, 8)
                Spacer()
            }
            .background(Image("ocean").backgroundImageModifier())
            
//            HalfModalView(isShown: $isEdited) {
//                VStack {
//                    Spacer()
//                    Text("Hello")
//                    Text("world")
//                }
//            }
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
