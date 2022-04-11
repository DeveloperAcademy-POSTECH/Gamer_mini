//
//  RewardDetailCard.swift
//  donggle
//
//  Created by 윤가희 on 2022/04/09.
//
import SwiftUI

struct DetailCardFront: View {

    let width: CGFloat
    let height: CGFloat
    @Binding var degree : Double
     
    var body: some View {

        ZStack(){
            VStack{
                ZStack(){
                    Text("2022.04.03")
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                    HStack(){
                        Spacer()
                        Image(systemName: "pencil")
                            .padding(.trailing, 30)
                    }
                }
                .padding(.top, 30.0)
                Spacer()
            }
            VStack{
                Text("야식 뜯어")
                    .font(.system(size: 22, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 265.0)
                    .padding(.bottom, 12.0)
                Text("오늘 도미노 세일 하던데 리버 꼬셔서 같이 먹어야지 우헤헤")
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 30.0)
                Spacer()
                
            }
        }
        .frame(width: 316.0, height: 418.0)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.1), radius: 28, x: 0, y: 12)
        .rotation3DEffect(Angle(degrees: degree), axis: (x:0, y:1, z:0))
        
    }
}
/*
struct DetailCardFront_Previews: PreviewProvider {
    static var previews: some View {
        DetailCardFront()
    }
}
*/
