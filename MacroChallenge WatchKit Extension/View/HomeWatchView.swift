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
        ZStack {
            TabView{
                BreathWatchView()
                EmergencyWatchView()
                AfterBreathingWatchView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWatchView()
    }
}
