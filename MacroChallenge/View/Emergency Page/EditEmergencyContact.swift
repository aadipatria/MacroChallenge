//
//  EditEmergencyContact.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 03/11/20.
//

import SwiftUI

struct EditEmergencyContact: View {
    
    @State var name: String = ""
    @State var number: String = ""
    
    var id: UUID
    @Binding var isEdited: Bool
    
    @Environment(\.managedObjectContext) var manageObjectContext
    @FetchRequest(fetchRequest: Emergency.getAllEmergency()) var contacts: FetchedResults<Emergency>
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.isEdited = false
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Text("Edit Contact")
                
                Spacer()
                
                Button(action: {
                    updateContact()
                }, label: {
                    Text("Done")
                })
            }
            .padding()
            
            Group {
                TextField("Name", text: $name)
                    .modifier(ClearButton(text: $name))
                    .padding()
                
                TextField("Number", text: $number)
                    .modifier(ClearButton(text: $number))
                    .keyboardType(.numberPad)
                    .padding()
            }
            .frame(width: 327, height: 60)
        }
        .onAppear(perform: {
            checkIdAndChangeData()
        })
    }
}

extension EditEmergencyContact {
    func checkIdAndChangeData() {
        for contact in contacts {
            if contact.id == self.id {
                self.name = contact.name!
                self.number = contact.number!
            }
        }
    }
    
    func updateContact() {
        for contact in contacts {
            if contact.id == self.id {
                contact.name = self.name
                contact.number = self.number
                
                do{
                    try self.manageObjectContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct EditEmergencyContact_Previews: PreviewProvider {
    @State static var isEdited = true
    static var previews: some View {
        EditEmergencyContact(id: UUID(), isEdited: $isEdited)
    }
}
