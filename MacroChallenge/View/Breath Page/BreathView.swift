//
//  BreathView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct BreathView: View {
    var body: some View {
        NavigationLink(
            destination: AfterBreathingView(),
            label: {
                Text("After Breathing")
            })
        
            .navigationBarTitle("Breath", displayMode: .inline)
    }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView()
    }
}
