//
//  ContentView.swift
//  HapticsTesting
//
//  Created by Yudis Huang on 07/10/20.
//
// yudis fix bisa

import SwiftUI
import CoreHaptics

struct hapticCoreData: View {
//    @State private var engine: CHHapticEngine?
//
//    var inhaleValue : Float = 4
//    var holdValue : Float = 5
//    var exhaleValue : Float = 7
//    var checkHaptic : Bool = true
    
    var body: some View {
        Text("ha")
//        VStack{
//            Button(action: {
//            prepareHaptics()
//
//
//            inhale(duration: inhaleValue)
//
//            exhale(duration: inhaleValue + holdValue + exhaleValue)
//
//            }, label: {
//            Text("Run Haptic")
//            }).padding()
//
//            Button(action: {
//
//
//                cancelHaptic()
//
//
//            }, label: {
//                Text("Cancel Haptics").foregroundColor(.black)
//            }).padding()
//        }
     

    }
        
    
//    func prepareHaptics(){
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return }
//        
//        do {
//            self.engine = try CHHapticEngine()
//            try engine?.start()
//            
//            
//        }catch{
//            print("There was an error creating the engine:\(error.localizedDescription)")
//        }
//    }
    
}

extension BreathView{
    
    func inhale(duration : Double){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        var events = [CHHapticEvent]()
        
        //from : durasi awal (pasti 0)
        //to : durasi akhir (ngambil data core total durasi breathingnya)
        //by : seberapa kenceng hepticsny
        for i in stride (from: 0, to: duration , by:0.125){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float( i/duration + 0.5))

            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1))

            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: TimeInterval(i))

            events.append(event)
        }
        
        
        do{
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)

        }catch{
            print("Failed to play pattern:\(error.localizedDescription)")
        }
        
    }
    
    func exhale(duration : Double){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return}
        
        var events = [CHHapticEvent]()
        
        //from : durasi awal (pasti 0)
        //to : durasi akhir (ngambil data core total durasi breathingnya)
        //by : seberapa kenceng hepticsny
        for i in stride (from: 0, to: duration , by:0.5){
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1.5 - (i)/(duration)))

            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1))

            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity,sharpness], relativeTime: TimeInterval(i))

            events.append(event)
        }
        
        
        do{
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        }catch{
            print("Failed to play pattern:\(error.localizedDescription)")
        }
        
    }
    
    func cancelHaptic(){
        
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {return }
        
        do {
            self.engine = try CHHapticEngine()
            engine?.stop()
            
            
        }catch{
            print("Success stopping engine")
        }    }
}

struct hapticCoreData_Previews: PreviewProvider {
    static var previews: some View {
        hapticCoreData()
    }
}
