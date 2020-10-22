//
//  ContentView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeWatchView: View {
    var body: some View {
        TabView{
            BreathWatchView()
            EmergencyWatchView()
            AfterBreathingWatchView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWatchView()
    }
}
