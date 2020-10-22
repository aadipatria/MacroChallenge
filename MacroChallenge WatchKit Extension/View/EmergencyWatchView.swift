//
//  EmergencyWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 19/10/20.
//

import SwiftUI

//struct contactDetail : Identifiable{
//   var id : Int = 0
//   var name : String = ""
//    var phoneNumber : String = ""
//
//}

struct EmergencyWatchView: View {
    var nomorAku = "02828282"
    var body: some View {
        
        Button(action: {self.call(number: nomorAku)
            
        }){
            Text("Call")}
        
    }
}

extension EmergencyWatchView{
    func call(number : String){
        
        if let NomorHape = URL(string: "tel:\(number)") {
            let wkExt = WKExtension.shared()
            wkExt.openSystemURL(NomorHape)
        }
    }
}

struct EmergencyWatchView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyWatchView()
    }
}
