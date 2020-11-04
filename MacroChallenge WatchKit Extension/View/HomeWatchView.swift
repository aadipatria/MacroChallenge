//
//  ContentView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeWatchView: View {
    
    var breath2DArray = [["Calm","4","7","8","0","True","True","True","123"],["Calm","4","7","8","0","True","True","True","123"],["Calm","4","7","8","0","True","True","True","123"]]
    var contact2DArray = [["01","haha","085"],["01","haha","085"],["01","haha","085"]]
    @EnvironmentObject var navPop : NavigationWatchPopObject
    
    var body: some View {
        ZStack {
            TabView(selection: $navPop.selected){
                BreathWatchView(breath2DArray: breath2DArray)
//                    .onTapGesture(perform: {
//                        navPop.selected = 1
//                    })
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
