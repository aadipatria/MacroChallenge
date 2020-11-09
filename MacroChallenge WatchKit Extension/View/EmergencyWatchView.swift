//
//  EmergencyWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 19/10/20.
//

import SwiftUI

struct EmergencyWatchView: View {
    
    //String 2 dimensi untuk attribute contack
    //CEK INDEX, SEMUA DALAM STRING -> HARUS DI CAST KALAU MAU DIPAKE
    //String -> 0 = id, 1 = name
    //UUID -> 2 = number
    @AppStorage("arrayOfContact") var arrayOfContact = Data()
    
    var body: some View {
        List {
            if Storage.userDefault(data: arrayOfContact)[0].isEmpty{
                Text("No Data")
            }else{
                ForEach(Storage.userDefault(data: arrayOfContact).indices, id: \.self){ idx in
                    Button {
                        self.call(number: "\(Storage.userDefault(data: arrayOfContact)[idx][2])")
                    } label: {
                        if !Storage.userDefault(data: arrayOfContact).isEmpty {
                            Text("\(Storage.userDefault(data: arrayOfContact)[idx][1])")
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
