//
//  BreathView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct BreathView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    
    var body: some View {
        VStack {
            Group {
                Button(action: {
                    navPop.toBreathing = true
                }, label: {
                    Text("After Breathing")
                })
                NavigationLink(
                    destination: AfterBreathingView(),
                    isActive : $navPop.toBreathing,
                    label: {
                        EmptyView()
                    })
            }
        }
        .navigationBarTitle("Breath", displayMode: .inline)
    }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        BreathView().environmentObject(NavigationPopObject())
    }
}
