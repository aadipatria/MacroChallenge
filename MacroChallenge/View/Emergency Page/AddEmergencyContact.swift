//
//  AddEmergencyContact.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 23/10/20.
//

import SwiftUI

struct AddEmergencyContact: View {
    @Environment(\.managedObjectContext) var manageObjectContext
    @State var name: String = ""
    @State var number: String = ""
    @Binding var isAddNewContact: Bool
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.isAddNewContact = false
                }, label: {
                    Text("Cancel")
                })
                
                Spacer()
                
                Text("Add New Contact")
                
                Spacer()
                
                Button {
                    saveToCoreData()
                    self.name = ""
                    self.number = ""
                } label: {
                    Text("Done")
                }
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
    }
}

extension AddEmergencyContact {
    func saveToCoreData() {
        let emergency = Emergency(context: manageObjectContext)
        emergency.name = name
        emergency.number = number
        emergency.id = UUID()
        
        do {
            try self.manageObjectContext.save()
        } catch {
            print(error)
        }
    }
}

struct AddEmergencyContact_Previews: PreviewProvider {
    @State static var isAddNewContact = true
    static var previews: some View {
        AddEmergencyContact(isAddNewContact: $isAddNewContact)
    }
}
