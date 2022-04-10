//
//  CardDetailView.swift
//  donggle
//
//  Created by 윤가희 on 2022/04/09.
//

import SwiftUI

struct CardDetailView: View {
    
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let width : CGFloat = 316
    let height: CGFloat = 418
    let durationAndDelay : CGFloat = 0.2
    
    func flipCard () {
         isFlipped = !isFlipped
         if isFlipped {
             withAnimation(.linear(duration: durationAndDelay)) {
                 backDegree = 90
             }
             withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                 frontDegree = 0
             }
         } else {
             withAnimation(.linear(duration: durationAndDelay)) {
                 frontDegree = -90
             }
             withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                 backDegree = 0
             }
         }
     }
    
    @State var Evaluation = false
    
    var body: some View {
        ZStack{
            Color(red: 249/255, green: 249/255, blue: 249/255).ignoresSafeArea()
            VStack{
                Text("보상 상세")
                    .font(.system(size: 17, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 12.0)
                Spacer()
            }
            VStack{
                ZStack{
                    DetailCardFront(width: width, height: height, degree: $backDegree)
                    DetailCardBack(width: width, height: height, degree: $frontDegree)

                }.onTapGesture{
                    flipCard()
                }
                Button(action: {
                    self.Evaluation = true
                }) {
                    Text("평가하기")
                        .font(.system(size: 17, weight: .regular))
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 160.0, height: 50)
                        .background(Color.yellow)
                        .cornerRadius(14)
                }
                .padding(.top, 32.0)
                .sheet(isPresented: self.$Evaluation){
                    GiftCheckView()
                }
            }
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
    }
}
