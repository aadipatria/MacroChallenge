//
//  ContentView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeWatchView: View {
    
    var breath2DArray = [[String]]()
    
    var body: some View {
        ZStack {
            TabView{
                BreathWatchView(breath2DArray: breath2DArray)
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
