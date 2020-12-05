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
    //kalau user ada 3 favorite, 3 pertama di array itu favorite
    @AppStorage("arrayOfBreathing") var arrayOfBreathing = Data()
    @EnvironmentObject var navPop: NavigationWatchPopObject
//    @State var toAnimation: Bool? = false
    
    var body: some View {
        List {
            if Storage.userDefault(data: arrayOfBreathing)[0].isEmpty{
                NavigationLink(destination : AnimationTestView(name: "Calm", inhale: 4, hold1: 7, exhale: 8, hold2: 0, haptic: true, sound: true),
                label: {
                    HStack {
                        Spacer()
                        VStack {
                            Text("Calm")
                                .foregroundColor(Color.white)
                            Text("4-7-8-0")
                                .foregroundColor(Color.white)
                        }
                        Spacer()
                    }
                })
                    .frame(height: WKInterfaceDevice.current().screenBounds.height * 0.55, alignment: .center)
                    .background(Image("forest_img")
                                    .resizable()
                                    .cornerRadius(8)
                                    .frame(width: WKInterfaceDevice.current().screenBounds.width * 0.9 ,height: WKInterfaceDevice.current().screenBounds.height * 0.60, alignment : .center))
                    
            }else{
                ForEach(Storage.userDefault(data: arrayOfBreathing).indices, id: \.self){ idx in
                    NavigationLink(
                        destination: AnimationWatchView(name: Storage.userDefault(data: arrayOfBreathing)[idx][0], inhale: Double(Storage.userDefault(data: arrayOfBreathing)[idx][1])!, hold1: Double(Storage.userDefault(data: arrayOfBreathing)[idx][2])!, exhale: Double(Storage.userDefault(data: arrayOfBreathing)[idx][3])!, hold2: Double(Storage.userDefault(data: arrayOfBreathing)[idx][4])!, haptic: Bool(Storage.userDefault(data: arrayOfBreathing)[idx][6])!, sound: Bool(Storage.userDefault(data: arrayOfBreathing)[idx][5])!),
                        label: {
                            if !Storage.userDefault(data: arrayOfBreathing).isEmpty {
                                VStack {
                                    Text("\(Storage.userDefault(data: arrayOfBreathing)[idx][0])")
                                    Text("\(Storage.userDefault(data: arrayOfBreathing)[idx][1])-\(Storage.userDefault(data: arrayOfBreathing)[idx][2])-\(Storage.userDefault(data: arrayOfBreathing)[idx][3])-\(Storage.userDefault(data: arrayOfBreathing)[idx][4])")
                                }
                            }
                        })
                        .frame(width: WKInterfaceDevice.current().screenBounds.width * 0.9, height: WKInterfaceDevice.current().screenBounds.height * 0.65, alignment: .center)
                        .background(Image("\(Storage.userDefault(data: arrayOfBreathing)[idx][8])_img")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(8))
                        .padding(.leading, -8)
                        .padding(.vertical, -15)
                }
            }
        }
        .listStyle(CarouselListStyle())
        .frame(width: WKInterfaceDevice.current().screenBounds.width * 0.9)
        .navigationBarTitle("Breathing")
    }
}

struct BreathWatchView_Previews: PreviewProvider {
    static var previews: some View {
        BreathWatchView()
    }
}
