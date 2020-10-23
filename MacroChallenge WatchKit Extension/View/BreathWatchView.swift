//
//  BreathWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 22/10/20.
//

import SwiftUI

struct BreathWatchView: View {
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
