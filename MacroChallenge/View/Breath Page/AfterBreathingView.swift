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
                    .modifier(ButtonModifier())
            }).padding()
            
            Button(action: {
                navPop.toBreathing = false
            }, label: {
                Text("Finish")
                    .foregroundColor(.black)
                    .modifier(ButtonStrokeModifier())
            }).padding()
            
            Button(action: {
                navPop.toBreathing = false
                navPop.page = 0
            }, label: {
                HStack {
                    Text("Emergency Contact")
                        .foregroundColor(.black)
                    Image("call")
                        .callIconModifier()
                }
            }).padding()
        }
        .navigationBarHidden(true)
        .background(Image("ocean").blurBackgroundImageModifier())
    }
}

struct AfterBreathingView_Previews: PreviewProvider {
    static var previews: some View {
        AfterBreathingView().environmentObject(NavigationPopObject())
    }
}
