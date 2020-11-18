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
    @State var isForest = true
    
    var body: some View {
        ZStack {
            playLooping
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                    .frame(width: 100, height: 0.6 * UIScreen.main.bounds.height)
                
                HStack {
                    Button(action: {
                        if idx != 0 {
                            idx -= 1
                        }
                        playLooping.player.moveBackground(name: "\(BackgroundAssetList.assetList[idx])")
                        isForest = true
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 100, height: 100)
                                .background(Blur(style: .systemThinMaterial)
                                .opacity(isForest == true ? 0.8 : 0.4))
                                .cornerRadius(100)
                            Text("Forest")
                                .foregroundColor(Color.white)
                        }
                    })
                    
                    Spacer()
                        .frame(width: 100)
                    
                    Button(action: {
                        if idx != BackgroundAssetList.assetList.count - 1 {
                            idx += 1
                        }
                        playLooping.player.moveBackground(name: "\(BackgroundAssetList.assetList[idx])")
                        isForest = false
                    }, label: {
                        ZStack {
                            Circle()
                                .fill(Color.clear)
                                .frame(width: 100, height: 100)
                                .background(Blur(style: .systemThinMaterial)
                                .opacity(isForest == true ? 0.4 : 0.8))
                                .cornerRadius(100)
                            Text("Lake")
                                .foregroundColor(Color.white)
                        }
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
        .onAppear() {
            checkBackground()
        }
    }
}

extension ChooseBackground {
    func checkBackground() {
        if self.currBackground == "forest" {
            self.isForest = true
            self.playLooping.player.moveBackground(name: "forest")
        }
        else {
            self.isForest = false
            self.playLooping.player.moveBackground(name: "lake")
        }
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
