//
//  BreathView.swift
//  MacroChallenge
//
//  Created by Kenji Surya Utama on 13/10/20.
//

import SwiftUI

struct BreathView: View {
    
    @EnvironmentObject var navPop : NavigationPopObject
    @FetchRequest(fetchRequest: Breathing.getAllBreathing()) var breaths: FetchedResults<Breathing>
    @State var index = 0
    
    var body: some View {
        VStack {
            // show data by index
            if !breaths.isEmpty{
                Text(String(breaths[index].name ?? ""))
                    .padding()
            }
            
            HStack {
                Button(action: {
                    changeLeft()
                }, label: {
                    Text ("Left")
                })
                Button(action: {
                    changeRight()
                }, label: {
                    Text ("Right")
                })
            }
            Group {
                Button(action: {
                    navPop.toBreathing = true
                    navPop.toEmergency = false
                }, label: {
                    Text("After Breathing")
                        .padding()
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
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onEnded({ value in
                        //left
                        if value.translation.width < 0 {
                            changeLeft()
                        }
                        if value.translation.width > 0 {
                            changeRight()
                        }
                    }))
    }
}

extension BreathView{
    func changeRight(){
        if index == breaths.count - 1 {
            index = 0
        }else{
            index += 1
        }
    }
    func changeLeft(){
        if index == 0 {
            index = breaths.count - 1
        }else{
            index -= 1
        }
    }
}

struct BreathView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        BreathView().environment(\.managedObjectContext, viewContext).environmentObject(NavigationPopObject())
    }
}
