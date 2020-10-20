//
//  ContentView.swift
//  testingCallFile
//
//  Created by Yudis Huang on 05/10/20.
//  Copyright © 2020 Yudis Huang. All rights reserved.
//

import SwiftUI

struct contactDetail : Identifiable {
    var id : Int = 0
    var name : String = ""
    var phoneNumber : String = ""
    var photo : String = ""
    
}

struct EmergencyView: View {
    
//    var contacts = [contactDetail]()
    //test
    var contacts : [contactDetail] = [
        contactDetail(id: 0, name: "Yudis", phoneNumber: "0895378412968", photo: "Lmfao"),
        contactDetail(id: 1, name: "Henny", phoneNumber: "0928828228282", photo: "GGWP")
    ]
    
    
    var body: some View {
       
        NavigationView {
            List{
            ForEach(contacts){
                i in
                VStack{
                    
                    HStack{
                        HStack{
                            
                            Text("Test")// photo
                            VStack{
                                Text("Name")
                                Text("Phone Number")
                                }
                        }
                    Spacer()
                        Button(action: {self.call()
                            
                        }){
                            Text("Call")}
                    }
                }.foregroundColor(.gray)
            }
            
        }.navigationBarTitle(Text("My Contacts"))
        }
    }
    
    func call(){
        var emergencyPhoneNumber = "123456"
        
        guard var phoneNumber =  emergencyPhoneNumber as String?, let url = URL(string:"telprompt://\(phoneNumber)") else {
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
