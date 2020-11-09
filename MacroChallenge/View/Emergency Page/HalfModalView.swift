//
//  HalfModalView.swift
//  MacroChallenge
//
//  Created by Vincent Alexander Christian on 02/11/20.
//

import SwiftUI

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

struct HalfModalView<Content: View>: View {
    @EnvironmentObject var navPop : NavigationPopObject
    @GestureState var dragState = DragState.inactive
    @Binding var isShown: Bool
    @State var value : CGFloat = 0
    
    var modalHeight: CGFloat = 400
    
    var content: () -> Content
    
    var body: some View {
        
        let drag = DragGesture()
            .updating($dragState) { (drag, state, transaction) in
                state = .dragging(translation: drag.translation)
            }
            .onEnded(onDragEnded)
        
        ZStack {
            Spacer()
                .frame(width: UIScreen.main.bounds.width, height: 800)
                .edgesIgnoringSafeArea(.vertical)
                .background(isShown ? Color.black.opacity(0.5 * fractionProgress(lowerLimit: 0, upperLimit: Double(modalHeight), current: Double(dragState.translation.height), inverted: true)) : Color.clear)
                .animation(.interpolatingSpring(stiffness: 300, damping: 30, initialVelocity: 10))
                .gesture(
                    TapGesture()
                        .onEnded({ _ in
                            self.isShown = false
                            navPop.tabIsHidden = false
                            hideKeyboard()
                        })
                )
                .offset(y: -100)
            
            VStack {
                Spacer()
                ZStack {
                    Color.green.opacity(1)
                        .frame(width: UIScreen.main.bounds.width, height: modalHeight)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    self.content()
                        .padding()
                        .padding(.bottom, 65)
//                        .padding(.bottom, 185)
                        .frame(width: UIScreen.main.bounds.size.width, height: modalHeight)
                        .clipped()
                }
                .offset(y: isShown ? ((self.dragState.isDragging && dragState.translation.height >= 1) ? dragState.translation.height : 0) : modalHeight)
                .animation(.interpolatingSpring(stiffness: 300, damping: 30, initialVelocity: 10))
                .gesture(drag)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .offset(y: -self.value)
        .onAppear() {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                let temp = UIResponder.keyboardFrameEndUserInfoKey
                let value = noti.userInfo![temp] as! CGRect
                let height = value.height
                self.value = height - 195
            }
            
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
                self.value = 0
            }
        }
    }
}

extension HalfModalView {
    func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold = modalHeight * (2/3)
        if drag.predictedEndTranslation.height > dragThreshold || drag.translation.height > dragThreshold {
            isShown = false
        }
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func fractionProgress(lowerLimit: Double = 0, upperLimit: Double, current: Double, inverted: Bool = false) -> Double {
        var val: Double = 0
        
        if current >= upperLimit {
            val = 1
        }
        else if current <= lowerLimit {
            val = 0
        }
        else {
            val = (current - lowerLimit)/(upperLimit - lowerLimit)
        }
        
        if inverted {
            return (1 - val)
        }
        else {
            return val
        }
    }
}
