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
//    var breath2DArray = [[String]]()
    var breath2DArray = [["Calm","4","7","8","0","True","True","True","123"],["Calm","4","7","8","0","True","True","True","123"],["Calm","4","7","8","0","True","True","True","123"]]
    
    var body: some View {
        List {
            ForEach(breath2DArray, id: \.self){ breath in
                NavigationLink(
                    destination: AfterBreathingWatchView(),
                    label: {
                        if !breath2DArray.isEmpty {
                            VStack {
                                Text("\(breath[0])")
                                Text("\(breath[1])-\(breath[2])-\(breath[3])-\(breath[4])")
                            }.frame(width: WKInterfaceDevice.current().screenBounds.width * 0.9, height: WKInterfaceDevice.current().screenBounds.height * 0.5, alignment: .center)
                        }
                        else {
                            Text("no contacts")
                        }
                    })
            }
        }
        .listStyle(CarouselListStyle())
    }
}

struct BreathWatchView_Previews: PreviewProvider {
    static var previews: some View {
        BreathWatchView()
    }
}
