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
    
    let sendWatchHelper = WatchHelper()
    
    @State var contact2DArray = [[String]]()
    
    var body: some View {
        VStack{
            Button {
                
            } label: {
                Text("Sync With Apple Watch")
            }
            
            NavigationLink("Add Contact", destination: AddEmergencyContact())
                .padding()
            
            List{
                ForEach(self.contacts){ contact in
                    VStack{
                        HStack{
                            HStack{
                                Text("\(contact.id)")// photo
                                
                                VStack{
                                    Text("\(contact.name!)")
                                    Text("\(contact.number!)")
                                }
                            }
                            
                            Spacer()
                            
                            Button {
                                self.call(number: contact.number!)
                            } label : {
                                Text("Call")
                                
                            }
                        }
                    }
                    .foregroundColor(.gray)
                }
                .onDelete { indexSet in
                    deleteItem(indexSet: indexSet)
                }
            }
            .navigationBarTitle("Emergency List", displayMode: .inline)
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
        EmergencyView().environmentObject(NavigationPopObject())
    }
}
