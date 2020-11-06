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
    var body: some View {
        List {
            if contact2DArray.isEmpty{
                Text("No Data")
            }else{
                ForEach(contact2DArray.indices, id: \.self){ idx in
                    Button {
                        self.call(number: "\(contact2DArray[idx][2])")
                    } label: {
                        if !contact2DArray.isEmpty {
                            Text("\(contact2DArray[idx][1])")
                                .frame(width: WKInterfaceDevice.current().screenBounds.width * 0.9, height: WKInterfaceDevice.current().screenBounds.height * 0.22, alignment: .center)
                        }
                        else {
                            Text("no contacts")
                        }
                    }
                }
            }
            
        }.listStyle(EllipticalListStyle())
        .navigationBarTitle("Emergency Call")
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
