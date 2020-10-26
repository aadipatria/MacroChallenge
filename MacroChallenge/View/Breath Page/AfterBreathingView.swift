//
//  AfterBreathingView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct AfterBreathingView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    
    var body: some View {
        VStack {
            Button(action: {
                navPop.toBreathing = false
                // gmn cara start lansung yg baru
            }, label: {
                Text("Repeat")
                    .foregroundColor(.black)
            }).padding()
            
            Button(action: {
                navPop.toBreathing = false
            }, label: {
                Text("Finish")
                    .foregroundColor(.black)
            }).padding()
            
            Button(action: {
                navPop.toEmergency = true
                navPop.toBreathing = false
            }, label: {
                Text("Emergency")
            }).padding()
        }
        .navigationBarHidden(true)
        .background(Image("ocean")
                        .blurBackgroundImageModifier()
                        .blur(radius: 2))
    }
}

struct AfterBreathingView_Previews: PreviewProvider {
    static var previews: some View {
        AfterBreathingView().environmentObject(NavigationPopObject())
    }
}
