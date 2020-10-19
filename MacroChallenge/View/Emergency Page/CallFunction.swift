//
//  ContentView.swift
//  testingCallFile
//
//  Created by Yudis Huang on 05/10/20.
//  Copyright © 2020 Yudis Huang. All rights reserved.
//

import SwiftUI

struct CallFunction: View {
    var body: some View {
        Button(action: {
            
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

struct CallFunction_Previews: PreviewProvider {
    static var previews: some View {
        CallFunction()
    }
}
