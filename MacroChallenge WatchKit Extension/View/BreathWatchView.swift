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
    var breath2DArray = [[String]]()
    @State var go = false
    
    var body: some View {
        List {
            if breath2DArray.isEmpty{
                Text("No Data")
            }else{
                ForEach(breath2DArray.indices, id: \.self){ idx in
                    NavigationLink(
                        destination: AfterBreathingWatchView(breathName: "\(breath2DArray[idx][0])"),
                        label: {
                            if !breath2DArray.isEmpty {
                                VStack {
                                    Text("\(breath2DArray[idx][0])")
                                    Text("\(breath2DArray[idx][1])-\(breath2DArray[idx][2])-\(breath2DArray[idx][3])-\(breath2DArray[idx][4])")
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
    }
}

struct BreathWatchView_Previews: PreviewProvider {
    static var previews: some View {
        BreathWatchView()
    }
}
