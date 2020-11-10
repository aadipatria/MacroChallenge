//
//  AddEmergencyContact.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 23/10/20.
//

import SwiftUI

struct AddEmergencyContact: View {
    @EnvironmentObject var navPop: NavigationPopObject
    @Environment(\.managedObjectContext) var manageObjectContext
    @State var name: String = ""
    @State var number: String = ""
    @Binding var isAddNewContact: Bool
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.isAddNewContact = false
                    navPop.tabIsHidden = false
                    hideKeyboard()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)

                })
                
                Spacer()
                
                Text("Add New Contact")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                
                Spacer()
                
                Button {
                    saveToCoreData()
                    self.name = ""
                    self.number = ""
                    self.isAddNewContact = false
                    navPop.tabIsHidden = false
                    hideKeyboard()
                } label: {
                    Text("Done")
                        .foregroundColor(.black)

                }
            }
            .padding()
            .frame(width: ScreenSize.windowWidth() * 0.9, height: 60)
            Divider()

            Group {
                TextField("Name", text: $name)
                    .modifier(ClearButton(text: $name))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor(.white))))
                
                TextField("Number", text: $number)
                    .modifier(ClearButton(text: $number))
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor(.white))))
            }
            .frame(width: ScreenSize.windowWidth() * 0.9, height: 60)
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
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct AddEmergencyContact_Previews: PreviewProvider {
    @State static var isAddNewContact = true
    static var previews: some View {
        AddEmergencyContact(isAddNewContact: $isAddNewContact)
    }
}
