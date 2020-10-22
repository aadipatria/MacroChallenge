//
//  ContentView.swift
//  testingCallFile
//
//  Created by Yudis Huang on 05/10/20.
//  Copyright © 2020 Yudis Huang. All rights reserved.
//

import SwiftUI

class contactDetail : Identifiable {
    var id : Int = 0
    var name : String = ""
    var phoneNumber : String = ""
    var photo : String = ""
    
    init(id: Int, name: String, phoneNumber: String, photo: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.photo = photo
    }
    
}

struct EmergencyView: View {
    
    var contacts : [contactDetail] = [
        contactDetail(id: 0, name: "Yudis", phoneNumber: "0895378412968", photo: "Lmfao"),
        contactDetail(id: 1, name: "Henny", phoneNumber: "0928828228282", photo: "GGWP")
    ]
    
    
    var body: some View {
       
        NavigationView {
            List{
            ForEach(contacts){i in
                VStack{
                    HStack{
                        HStack{
                            
                            Text("\(i.id)")// photo
                            VStack{
                                Text("\(i.name)")
                                Text("\(i.phoneNumber)")
                                }
                        }
                        Spacer()
                        
                        Button(action: {self.call(number: i.phoneNumber)
                            
                        }){
                            Text("Call")}
                    }
                }.foregroundColor(.gray)
            }
            
        }.navigationBarTitle(Text("My Contacts"))
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
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
