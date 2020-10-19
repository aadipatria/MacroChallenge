//
//  EmergencyView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct EmergencyView: View {
    var body: some View {
        Button(action: {
            //test
            // this is where the variable emergencyPhoneNumber assigned a value of coredata
            var emergencyPhoneNumber = "123456"
            
            guard var phoneNumber =  emergencyPhoneNumber as String?, let url = URL(string:"telprompt://\(phoneNumber)") else {
                return
            }
            
            UIApplication.shared.open(url)
            
        }) {
            Text("Emergency Call")
        }
    }
    
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
