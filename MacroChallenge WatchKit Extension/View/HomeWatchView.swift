//
//  ContentView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeWatchView: View {
    
    var breathName = "lol"
    var inhale: Int16 = 0
    var hold1: Int16 = 0
    var exhale: Int16 = 0
    var hold2: Int16 = 0
    var sound = false
    var haptic = false
    
    var body: some View {
        VStack {
            Text(breathName)
            Text("\(inhale)")
            Text("\(hold1)")
            Text("\(exhale)")
            Text("\(hold2)")
            Text("\(String(sound))")
            Text("\(String(haptic))")
//            Text(tes)
//                .padding()
//            NavigationLink(
//                destination: AfterBreathingWatchView(),
//                label: {
//                    Text("After Breathing")
//                })
//            NavigationLink(
//                destination: EmergencyWatchView(),
//                label: {
//                    Text("Emergency")
//                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWatchView()
    }
}
