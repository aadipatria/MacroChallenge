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
    
    //String 2 dimensi untuk attribute contack
    //CEK INDEX, SEMUA DALAM STRING -> HARUS DI CAST KALAU MAU DIPAKE
    //String -> 0 = id, 1 = name
    //Number -> 2 = number
//    var contact2DArray = [[String]]()
    var contact2DArray = [["01","haha","085"],["01","haha","085"],["01","haha","085"]]
    var body: some View {
        List {
            ForEach(contact2DArray, id: \.self){ contact in
                Button {
                    self.call(number: "\(contact[2])")
                } label: {
                    if !contact2DArray.isEmpty {
                        Text("\(contact[1])")
                            .frame(width: WKInterfaceDevice.current().screenBounds.width * 0.9, height: WKInterfaceDevice.current().screenBounds.height * 0.22, alignment: .center)
                    }
                    else {
                        Text("no contacts")
                    }
                }
            }
        }
        .listStyle(EllipticalListStyle())
        
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
