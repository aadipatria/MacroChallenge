//
//  ContentView.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 12/10/20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Navigation")
                    .padding()
                NavigationLink(
                    destination: BreathListView(),
                    label: {
                        Text("Breath List")
                    })
                    .padding()
                NavigationLink(
                    destination: BreathView(),
                    label: {
                        Text("Breath Now")
                    })
                    .padding()
                NavigationLink(
                    destination: EmergencyView(),
                    label: {
                        Text("Emergency")
                    })
                    .padding()
            }
            .navigationBarTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
