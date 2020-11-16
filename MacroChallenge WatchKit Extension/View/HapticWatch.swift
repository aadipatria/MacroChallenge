
//
//  ContentView.swift
//  hapticOnWatch
//
//  Created by Yudis Huang on 10/11/20.
//

import SwiftUI
import AVFoundation

struct HapticWatch: View {
    @State var countTime :Int = 0
    @State var timer  = Timer.publish(every: 1, on: .main, in: .common)
    var inHaleDuration : Int = 4
    var holdDuration : Int = 5
    var exHaleDuration : Int = 7
    var interval : Double = 1.0
    
    var body: some View {
        VStack{
        
        Button(action: {
            timer  = Timer.publish(every: 1, on: .main, in: .common)
            
            timer.connect()
            countTime = 0
            
        }, label: {
            Text("Try haptic")
        }).onReceive(timer, perform: { _ in
            if(self.countTime <= inHaleDuration + holdDuration + exHaleDuration){
                
    
                self.countTime = self.countTime + 1
                
                print(countTime)
                
                //inhale section
                if self.countTime == 1 {
                    WKInterfaceDevice.current().play(.success)
                    
                //hold section
                }else if self.countTime == inHaleDuration + 1 {
                    WKInterfaceDevice.current().play(.retry)
                    
                //exhale section
                }else if self.countTime == inHaleDuration + holdDuration + 1 {
                    WKInterfaceDevice.current().play(.failure)
                    
                }
            }
        })
        
        Button(action: {
            
            timer.connect().cancel()
            
        }, label: {
            Text("Stop haptic")
        })


        }
    }
}


struct HapticWatch_Previews: PreviewProvider {
    static var previews: some View {
        HapticWatch()
    }
}
