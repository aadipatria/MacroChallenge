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
    
    var body: some View {
        ZStack {
            TabView(selection: $navPop.selected){
                BreathWatchView(breath2DArray: breath2DArray)
                    .tag(0)
                EmergencyWatchView(contact2DArray: contact2DArray)
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
