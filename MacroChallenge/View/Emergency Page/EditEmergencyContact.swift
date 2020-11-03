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
    @Binding var contactEdited: Bool
    
    @Environment(\.managedObjectContext) var manageObjectContext
    @FetchRequest(fetchRequest: Emergency.getAllEmergency()) var contacts: FetchedResults<Emergency>
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.contactEdited = false
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
        print(self.id)
        for contact in contacts {
            print(contact.id)
            if contact.id == self.id {
                self.name = contact.name!
                self.number = contact.number!
                break
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
                
                break
            }
        }
    }
}

struct EditEmergencyContact_Previews: PreviewProvider {
    @State static var isEdited = true
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        EditEmergencyContact(id: UUID(), contactEdited: $isEdited).environment(\.managedObjectContext, viewContext)
    }
}
