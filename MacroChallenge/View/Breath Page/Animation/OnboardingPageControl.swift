//
//  OnboardingPageControl.swift
//  MacroChallenge
//
//  Created by Aghawidya Adipatria on 13/11/20.
//

import SwiftUI

struct OnboardingPageControl: View {
//    @State var currentPage: Int = 0
    @Binding var currentPage: Int
    @State private var firstPageSelected: Bool = true
    @State private var secondPageSelected: Bool = false
    @State private var thirdPageSelected: Bool = false
    
//    @State private var opacity1: Double = 0.5
//    @State private var opacity2: Double = 0.5
//    @State private var opacity3: Double = 0.5
//
//    @State private var offset1: CGFloat = 0
//    @State private var offset2: CGFloat = 0
//    @State private var offset3: CGFloat = 0
    
    private let unselectedSize: CGFloat = 24
    private let selectedSize: CGFloat = 32
    private let baseOffset: CGFloat = 50.5 // 40/2 + 8 + 45/2
    
//    @State var buzz: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
//                Circle()
//                    .frame(width: 45, height: 45)
//                    .foregroundColor(Color.white)
//                    .opacity(opacity1)
//                    .offset(x: 0, y: offset1)
                
                OnboardingSymbols(
                    isSelected: $firstPageSelected,
                    pageSelection: $currentPage,
                    targetPage: 1,
                    image: "OnboardingSymbol1")
                //.offset(x: buzz, y: 0)
                //.onAnimationCompleted(for: buzz, completion: {buzz = 0})
            }
            
            Image("OnboardingLine")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.white)
                .frame(width: 1, height: 40)
            
            ZStack {
//                Circle()
//                    .frame(width: 45, height: 45)
//                    .foregroundColor(Color.white)
//                    .opacity(opacity2)
//                    .offset(x: 0, y: offset2)
                
                OnboardingSymbols(
                    isSelected: $secondPageSelected,
                    pageSelection: $currentPage,
                    targetPage: 2,
                    image: "OnboardingSymbol2")
            }
            
            Image("OnboardingLine")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.white)
                .frame(width: 1, height: 40)
            
            OnboardingSymbols(
                isSelected: $thirdPageSelected,
                pageSelection: $currentPage,
                targetPage: 3,
                image: "OnboardingSymbol3",
                compressedHeight: true)
            
//            Button(action:{
//                withAnimation(.linear(duration: 1)) {
//                    switch currentPage {
//                    case 0:
//                        currentPage = 1
//                    case 1:
//                        currentPage = 2
//                    case 2:
//                        currentPage = 0
//                    default:
//                        return
//                    }
//                }
//
////                withAnimation(Animation.linear(duration: 0.05).repeatCount(4, autoreverses: true).delay(0.00)) {
////                    self.buzz = -15
////                }
//            }) {
//                Rectangle().frame(height: 40)
//            }
        }
        .background(Color.clear)
        .onChange(of: currentPage, perform: { newPage in
//        .onChange(of: currentPage, perform: { [currentPage] newPage in
//            switch currentPage {
//            case 0:
//                self.offset2 = -1 * baseOffset
//
//                withAnimation(Animation.linear(duration: 0.5)) {
//                    self.offset1 = baseOffset
//                }
//
//                withAnimation(Animation.linear(duration: 0.5).delay(0.5)) {
//                    self.offset2 = 0
//                }
//            default:
//                return
//            }
        
            switch newPage {
            case 1:
                firstPageSelected = true
                secondPageSelected = false
                thirdPageSelected = false
            case 2:
                firstPageSelected = false
                secondPageSelected = true
                thirdPageSelected = false
            case 3:
                firstPageSelected = false
                secondPageSelected = false
                thirdPageSelected = true
            default:
                firstPageSelected = true
                secondPageSelected = false
                thirdPageSelected = false
            }
        })
    }
}

struct OnboardingSymbols: View {
    @Binding var isSelected: Bool
    @Binding var pageSelection: Int
    @State var targetPage: Int
    @State var image: String = ""
    @State var compressedHeight: Bool = false
    
    let unselectedSize: CGFloat = 24
    let selectedSize: CGFloat = 28
    let overlaySize: CGFloat = 45
    
    var body: some View {
        Group {
            if isSelected {
                Circle()
                    .foregroundColor(Color.white)
                    .frame(width: overlaySize, height: overlaySize)
                    .mask(
                        ZStack {
                            Circle()
                                .foregroundColor(Color.white)
                                .frame(width: overlaySize, height: overlaySize)
                            Image(image)
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color.black)
                                .frame(
                                    width: selectedSize,
                                    height: compressedHeight ? selectedSize * 0.8 : selectedSize)
                        }
                        .compositingGroup()
                        .luminanceToAlpha()
                    )
            } else {
                Button(action: {self.pageSelection = self.targetPage}) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.clear)
                            .frame(width: selectedSize, height: selectedSize)
                        Image(image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(
                                width: unselectedSize,
                                height: compressedHeight ? unselectedSize * 0.8 : unselectedSize)
                    }
                }
            }
        }
        //.animation(.none)
    }
}

//struct OnboardingPageControl_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPageControl()
//    }
//}
