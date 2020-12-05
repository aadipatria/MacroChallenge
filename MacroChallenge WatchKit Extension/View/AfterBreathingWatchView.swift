//
//  AfterBreathingWatchView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Kenji Surya Utama on 19/10/20.
//

import SwiftUI

struct AfterBreathingWatchView: View {
    @EnvironmentObject var navPop: NavigationWatchPopObject
    @Binding var isBreathing: Bool
    @Binding var afterBreathing: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image("AfterBreathingSmiley")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text("Well Done!")
                .font(.system(size: 14, weight: .semibold, design: .default))
            
            Text("You have finished this breathing session.")
                .multilineTextAlignment(.center)
                .font(.system(size: 12, weight: .light, design: .default))
            
            HStack(spacing: 2) {
                Button(action: {
                    self.afterBreathing = false
                    self.isBreathing = true
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(.sRGB, red: 36/255, green: 36/255, blue: 36/255, opacity: 1))
                        Text("Repeat")
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .clipShape(RoundedCorner(radius: 22, corners: [.topLeft, .bottomLeft]))
                .clipShape(RoundedCorner(radius: 4.5, corners: [.topRight, .bottomRight]))
                
                
                Button(action: {
                    self.afterBreathing = false
                    navPop.breathCycles = 0
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color.blue)
                        Text("Finish")
                            .font(.system(size: 14, weight: .medium))
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .clipShape(RoundedCorner(radius: 22, corners: [.topRight, .bottomRight]))
                .clipShape(RoundedCorner(radius: 4.5, corners: [.topLeft, .bottomLeft]))
            }
            .frame(maxHeight: 40)
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .background(Color.black)
    }
}

//struct AfterBreathingWatchView_Previews: PreviewProvider {
//    static var previews: some View {
//        AfterBreathingWatchView()
//    }
//}
