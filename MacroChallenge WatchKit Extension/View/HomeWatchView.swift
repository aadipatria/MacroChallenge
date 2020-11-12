//
//  ContentView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeWatchView: View {
    
//    var breath2DArray = [[String]]()
//    var contact2DArray = [[String]]()
    @EnvironmentObject var navPop : NavigationWatchPopObject
    
    var body: some View {
        ZStack {
            TabView(selection: $navPop.selected){
                AnimationTestView()
                    .tag(2)
                BreathWatchView()
                    .tag(0)
                EmergencyWatchView()
                    .tag(1)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWatchView().environmentObject(NavigationWatchPopObject())
    }
}
