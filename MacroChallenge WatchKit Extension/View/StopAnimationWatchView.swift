//
//  WatchBreathStopView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Aghawidya Adipatria on 18/11/20.
//

import SwiftUI

struct StopAnimationWatchView: View {
    @EnvironmentObject var navPop: NavigationWatchPopObject
    @State var stopAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: {
                stopAction()
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(Color.watchButton)
                    
                    Text("Stop")
                        .font(.system(size: 14, weight: .bold))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxHeight: 48)
            
            Button(action: {
                stopAction()
                navPop.selected = 1
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .foregroundColor(Color.watchStopButton)
                    
                    Text("Call a friend")
                        .font(.system(size: 14, weight: .bold))
                }
            }
            .buttonStyle(PlainButtonStyle())
            .frame(maxHeight: 48)
        }
        .padding(.horizontal, 16)
    }
}

//struct StopAnimationWatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        StopAnimationWatchView()
//    }
//}
