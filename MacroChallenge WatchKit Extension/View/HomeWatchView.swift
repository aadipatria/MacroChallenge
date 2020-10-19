//
//  ContentView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeWatchView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            NavigationLink(
                destination: AfterBreathingWatchView(),
                label: {
                    Text("After Breathing")
                })
            NavigationLink(
                destination: EmergencyWatchView(),
                label: {
                    Text("Emergency")
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeWatchView()
    }
}
