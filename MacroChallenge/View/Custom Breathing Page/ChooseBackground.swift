//
//  ChooseBackground.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 17/11/20.
//

import SwiftUI

struct BackgroundAssetList {
    static let assetList: [String] = ["forest","lake"]
}

struct ChooseBackground: View {
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    @Environment(\.managedObjectContext) var manageObjectContext
    @EnvironmentObject var navPop: NavigationPopObject
    @Binding var isChooseBackground: Bool
    @Binding var currBackground: String
    @State var idx = 0
    var playLooping = LoopingPlayer()
    
    var body: some View {
        ZStack {
            playLooping
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(width: 100, height: 0.6 * UIScreen.main.bounds.height)
                    .background(Color.green)
                
                HStack {
                    Button(action: {
                        if idx != 0 {
                            idx -= 1
                        }
                        playLooping.player.moveBackground(name: "\(BackgroundAssetList.assetList[idx])")
                    }, label: {
                        Text("Previous")
                            .foregroundColor(Color.white)
                    })
                    
                    Spacer()
                        .frame(width: 100)
                    
                    Button(action: {
                        if idx != BackgroundAssetList.assetList.count - 1 {
                            idx += 1
                        }
                        playLooping.player.moveBackground(name: "\(BackgroundAssetList.assetList[idx])")
                    }, label: {
                        Text("Next")
                            .foregroundColor(Color.white)
                    })
                }
                .padding(.top, 50)
                
                Button(action: {
                    saveBackground()
                    self.isChooseBackground = false
                }, label: {
                    Text("Save")
                        .foregroundColor(Color.white)
                })
                .padding(.top, 50)
            }
        }
    }
}

extension ChooseBackground {
    func checkBackground() {
        self.currBackground = BackgroundAssetList.assetList[idx]
    }
    
    func saveBackground() {
        self.currBackground = BackgroundAssetList.assetList[idx]
    }
}

struct ChooseBackground_Previews: PreviewProvider {
    @State static var isChooseBackground = true
    @State static var currBackground = "forest"
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        ChooseBackground(isChooseBackground: $isChooseBackground, currBackground: $currBackground)
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(NavigationPopObject())
    }
}
