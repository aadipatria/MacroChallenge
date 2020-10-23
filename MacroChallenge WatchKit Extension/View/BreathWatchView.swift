//
//  BreathWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 22/10/20.
//

import SwiftUI

struct BreathWatchView: View {
    
    //String 2 dimensi untuk attribute breath
    //CEK INDEX, SEMUA DALAM STRING -> HARUS DI CAST KALAU MAU DIPAKE
    //String -> 0 = name,
    //Int16 -> 1 = inhale, 2 = hold1, 3 = exhale, 4 = hold2,
    //Boolean -> 5 = sound, 6 = haptic, 7 = favorite,
    //UUID -> 8 = id
    var breath2DArray = [[String]]()
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .ignoresSafeArea(.all)
                .frame(width: 500, height: 500, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("Breath")
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(.all)
    }
}

struct BreathWatchView_Previews: PreviewProvider {
    static var previews: some View {
        BreathWatchView()
    }
}
