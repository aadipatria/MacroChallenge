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
    @Binding var off: CGFloat
    
    var id: UUID
    
    @Binding var contactEdited: Bool
    @EnvironmentObject var navPop: NavigationPopObject
    @Environment(\.managedObjectContext) var manageObjectContext
    @FetchRequest(fetchRequest: Emergency.getAllEmergency()) var contacts: FetchedResults<Emergency>
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.contactEdited = false
                    }
                    navPop.tabIsHidden = false
                    hideKeyboard()
                    self.off = 200
                }, label: {
                    Text("Cancel")
                        .foregroundColor(.blue)
                })
                
                Spacer()
                
                Text("Edit Contact")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: {
                    updateContact()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        self.contactEdited = false
                    }
                    navPop.tabIsHidden = false
                    hideKeyboard()
                    self.off = 200
                }, label: {
                    Text("Done")
                        .foregroundColor(self.name == "" ? Color.gray : (self.number == "" ? Color.gray : Color.blue))
                })
                .disabled(self.name == "" ? true : (self.number == "" ? true : false))
            }
            .padding()
            .frame(width: ScreenSize.windowWidth() * 0.9, height: 60)
            Divider()
            
            Group {
                TextField("Name", text: $name)
                    .modifier(ClearButton(text: $name))
                    .accentColor(.black)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor(.white))))
                
                TextField("Number", text: $number)
                    .modifier(ClearButton(text: $number))
                    .accentColor(.black)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(UIColor(.white))))
            }
            .frame(width: ScreenSize.windowWidth() * 0.9, height: 60)
        }
    }
}

extension EditEmergencyContact {
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
