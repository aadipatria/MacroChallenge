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
            call(number: "123456")
        }) {
            Text("Emergency Call")
        }
    }
    
}
extension EmergencyView{
    func call(number : String){
        // this is where the variable emergencyPhoneNumber assigned a value of coredata
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
