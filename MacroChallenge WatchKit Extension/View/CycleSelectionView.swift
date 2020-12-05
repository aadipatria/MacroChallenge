//
//  CycleSelectionView.swift
//  MacroChallenge WatchKit Extension
//
//  Created by Aghawidya Adipatria on 04/12/20.
//

import SwiftUI

struct CycleSelectionView: View {
    @Binding var cycleTime: Int
    @State var crownSelection: Double = 1.0
    @State var ringArc: CGFloat = 1/3
    @State var buttonAction: () -> () = {}
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                AnimatedRingWatch(
                    binding: $ringArc,
                    donutRadius: 0.65,
                    isProgressBar: true)
                
                Text("\(Int(cycleTime)) Min" + (cycleTime > 1 ? "s" : ""))
                    .animation(nil)
                    .font(.system(size: 14, weight: .bold, design: .default))
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 34)
            }
            .padding(8)
            .focusable(true)
            .digitalCrownRotation($crownSelection, from: 1.0, through: 3.0, by: 1.0, sensitivity: .medium)
            
            Button(action: {
                buttonAction()
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.yellow)
                    .frame(maxWidth: 98, maxHeight: 28)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .background(Color.clear)
        .onChange(of: crownSelection, perform: { value in
            cycleTime = Int(value)
        })
        .onChange(of: cycleTime, perform: { value in
            withAnimation(.linear) {
                ringArc = CGFloat(cycleTime) / 3
            }
        })
    }
}

//struct CycleSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CycleSelectionView()
//    }
//}
