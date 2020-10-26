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
    
    
    var body: some View {
        VStack {
            Button {
                saveToCoreData()
            } label: {
                Text("Add Contact")
            }

            TextField("Name", text: $name)
                .padding()
                .multilineTextAlignment(.center)
            TextField("Number", text: $number)
                .keyboardType(.numberPad)
                .padding()
                .multilineTextAlignment(.center)
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
    static var previews: some View {
        AddEmergencyContact()
    }
}
