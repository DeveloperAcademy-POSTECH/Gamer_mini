//
//  CardDetailView.swift
//  donggle
//
//  Created by 윤가희 on 2022/04/09.
//

import SwiftUI

struct CardDetailView: View {
    
    var reward: Reward
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @State var showingSheet = false
    
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
        
        NavigationView{
        ZStack{
            Color(red: 249/255, green: 249/255, blue: 249/255).ignoresSafeArea()
            
            VStack{
                if let stressIndex = mainStress.firstIndex { stress in
                    return reward.stressKey == stress.id
                }{
                    ZStack{
                        DetailCardFront(width: width, height: height, degree: $backDegree, reward: reward)
                        DetailCardBack(width: width, height: height, degree: $frontDegree, stress: mainStress[stressIndex])
                    }.onTapGesture{
                        flipCard()
                   }
                }else{
                    ZStack{
                        DetailCardFront(width: width, height: height, degree: $backDegree, reward: reward)
                    }
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
                    GiftCheckView(reward: reward)
                }
            }
        }
        .navigationBarTitle("보상 상세", displayMode: .inline)
        .navigationBarItems(leading: Button(action : {
            self.mode.wrappedValue.dismiss()
        }){
            Image(systemName: "chevron.left")
                .foregroundColor(Color.black)
                .padding(8)
        }, trailing:
                Button(action: {
                    self.showingSheet = true
                }, label: {
                    Image(systemName: "ellipsis")
                        .padding(8)
                        .foregroundColor(Color.black)
        })
                    .confirmationDialog("", isPresented: $showingSheet, titleVisibility: .hidden){
                        Button("보상 수정"){
                            //UpdateRewardView 모달 띄우기
                        }
                        Button("보상 삭제", role: .destructive){
                            
                        }
                        Button("취소", role: .cancel){
                            
                        }
                    }
        )
        }
    }
}
/*
struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView(reward: reward)
    }
}
*/
