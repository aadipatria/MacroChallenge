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
    //UUID -> 2 = number
    @State var contact2DArray = [[String]]()
    
    var nomorAku = "02828282"
    var body: some View {
        Button {
            self.call(number: nomorAku)
        } label: {
            if !contact2DArray.isEmpty {
                Text("\(contact2DArray[0][1])")
            }
            else {
                Text("no contacts")
            }
        }
        .onAppear() {
            updateData()
        }
    }
}

extension EmergencyWatchView{
    func call(number : String){
        if let NomorHape = URL(string: "tel:\(number)") {
            let wkExt = WKExtension.shared()
            wkExt.openSystemURL(NomorHape)
        }
    }
    
    func updateData() {
        if let tempArr = UserDefaults.standard.array(forKey: "arrayOfContact") as? [[String]] {
            contact2DArray = tempArr
            
        }
    }
}

struct EmergencyWatchView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyWatchView()
    }
}
