//
//  BreathListView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct BreathListView: View {
    
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    
    var body: some View {
        VStack{
            NavigationLink(
                destination: CustomBreathingView(),
                label: {
                    Text("Custom Breathing View")
                })
                .navigationBarTitle("Breath List", displayMode: .inline)
            
            List {
                ForEach(self.breaths) { breath in
                    Text("\(breath.name ?? "My Breath") = \(breath.inhale) inhale || \(breath.hold1) hold || \(breath.exhale) exhale || \(breath.hold2) hold || sound \(breath.sound == true ? "on" : "off") || haptic \(breath.haptic == true ? "on" : "off")")
                }
            }
        }
    }
}

struct BreathListView_Previews: PreviewProvider {
    static var previews: some View {
        BreathListView()
    }
}
