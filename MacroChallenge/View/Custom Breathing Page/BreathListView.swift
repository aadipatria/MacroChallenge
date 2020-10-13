//
//  BreathListView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct BreathListView: View {
    var body: some View {
        NavigationLink(
            destination: CustomBreathingView(),
            label: {
                Text("Custom Breathing View")
            })
        
            .navigationBarTitle("Breath List", displayMode: .inline)
    }
}

struct BreathListView_Previews: PreviewProvider {
    static var previews: some View {
        BreathListView()
    }
}
