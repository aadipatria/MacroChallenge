//
//  BreathWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 22/10/20.
//

import SwiftUI

struct BreathWatchView: View {
    
    //String 2 dimensi untuk attribute breath
    //CEK INDEX, SEMUA DALAM STRING -> HARUS DI CAST KALAU MAU DIPAKE
    //String -> 0 = name,
    //Int16 -> 1 = inhale, 2 = hold1, 3 = exhale, 4 = hold2,
    //Boolean -> 5 = sound, 6 = haptic, 7 = favorite,
    //UUID -> 8 = id
    //kalau user ada 3 favorite, 3 pertama di array itu favorite
//    @State var breath2DArray = [[String]]()
    @AppStorage("arrayOfBreathing") var arrayOfBreathing = Data()
    
    var body: some View {
        List {
            if Storage.userDefault(data: arrayOfBreathing).isEmpty{
                Text("No Data")
            }else{
                ForEach(Storage.userDefault(data: arrayOfBreathing).indices, id: \.self){ idx in
                    NavigationLink(
                        destination: AfterBreathingWatchView(breathName: "\(Storage.userDefault(data: arrayOfBreathing)[idx][0])"),
                        label: {
                            if !Storage.userDefault(data: arrayOfBreathing).isEmpty {
                                VStack {
                                    Text("\(Storage.userDefault(data: arrayOfBreathing)[idx][0])")
                                    Text("\(Storage.userDefault(data: arrayOfBreathing)[idx][1])-\(Storage.userDefault(data: arrayOfBreathing)[idx][2])-\(Storage.userDefault(data: arrayOfBreathing)[idx][3])-\(Storage.userDefault(data: arrayOfBreathing)[idx][4])")
                                }
                            }
                        })
                        .frame(width: WKInterfaceDevice.current().screenBounds.width * 0.9, height: WKInterfaceDevice.current().screenBounds.height * 0.65, alignment: .center)
                        .background(Color.blue)
                }
//                .padding(.top, 20)
            }
        }
        .listStyle(CarouselListStyle())
        .navigationBarTitle("Breathing")
        .onAppear() {
//            update()
        }
    }
}

extension BreathWatchView {
//    func update() {
//        if let tempArr = UserDefaults.standard.array(forKey: "arrayOfBreathing") as? [[String]] {
//            breath2DArray = tempArr
//        }
//    }
}

struct BreathWatchView_Previews: PreviewProvider {
    static var previews: some View {
        BreathWatchView()
    }
}
