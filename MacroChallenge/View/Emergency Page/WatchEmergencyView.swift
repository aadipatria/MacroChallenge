//
//  ContentView.swift
//  watchEmergencyCall WatchKit Extension
//
//  Created by Yudis Huang on 05/10/20.
//  Copyright © 2020 Yudis Huang. All rights reserved.
//

import SwiftUI

struct WatchEmergencyView: View {
    var body: some View {
        Button(action:{
            let phone = "123456"
            
            
            if let NomorHape = URL(string: "tel:\(phone)") {
                let wkExt = WKExtension.shared()
                wkExt.openSystemURL(NomorHape)
            }
            
        })  {
        Text("Emergency Button")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
