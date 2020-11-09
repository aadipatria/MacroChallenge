//
//  EditEmergencyContact.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 03/11/20.
//

import SwiftUI

struct EditEmergencyContact: View {
    
    @Binding var name: String
    @Binding var number: String
    @State var value: CGFloat = 0
    
    var id: UUID
    
    @Binding var contactEdited: Bool
    @EnvironmentObject var navPop: NavigationPopObject
    @Environment(\.managedObjectContext) var manageObjectContext
    @FetchRequest(fetchRequest: Emergency.getAllEmergency()) var contacts: FetchedResults<Emergency>
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    self.contactEdited = false
                    navPop.tabIsHidden = false
                    hideKeyboard()
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.black)
                })
                
                Spacer()
                
                Text("Edit Contact")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)

                
                Spacer()
                
                Button(action: {
                    updateContact()
                    self.contactEdited = false
                    navPop.tabIsHidden = false
                    hideKeyboard()
                }, label: {
                    Text("Done")
                        .foregroundColor(.black)

                })
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

extension EditEmergencyContact {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func checkIdAndChangeData() {
        for contact in contacts {
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
//
//struct EditEmergencyContact_Previews: PreviewProvider {
//    @State static var isEdited = true
//    @State static var id = UUID()
//    static var previews: some View {
//        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        EditEmergencyContact(id: $id, contactEdited: $isEdited).environment(\.managedObjectContext, viewContext)
//    }
//}
