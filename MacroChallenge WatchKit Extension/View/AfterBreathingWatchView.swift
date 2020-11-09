//
//  AfterBreathingWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 19/10/20.
//

import SwiftUI

struct AfterBreathingWatchView: View {
    
    @State var breathName : String
    
    var body: some View {
        Text(breathName)
            .onAppear {
                print("aa")
            }
    }
}

struct AfterBreathingWatchView_Previews: PreviewProvider {
    static var previews: some View {
        AfterBreathingWatchView(breathName: "BukanCalm")
        
    }
}
