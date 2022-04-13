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
    var reward: Reward

    var dateFormatText: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY.M.d"
        return formatter
    }()
    
    var body: some View {
        
        VStack(){
            VStack{
                Text("\(reward.date, formatter: dateFormatText)")
                    .font(.system(size: 15, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 30.0)
                Spacer()
                Text("\(stringToImoticon(category: reward.category[0]))")
                    .font(.system(size: 100, weight: .regular))
                Text(reward.title)
                    .font(.system(size: 22, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.top, 1.0)
                Text(reward.content)
                    .font(.system(size: 17, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.top, 12.0)
                    .padding([.leading, .trailing], 30.0)
                Spacer()
            }
            .foregroundColor(Color.black)
        }
        .frame(width: 316.0, height: 418.0)
        .background(Color.white)
        .cornerRadius(20)
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
