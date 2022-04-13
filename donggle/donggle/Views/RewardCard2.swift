
//
//  RewardCard.swift
//  donggle
//
//  Created by 윤가희 on 2022/04/07.
//

import SwiftUI

struct RewardCard2: View {
    
    var title: String
    var category: String
    var index: Int
    
    var body: some View {
        let rgb = setRewardColor(str: category)
        VStack{
            HStack {
                Circle()
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color.gray.opacity(0.2))
                    .overlay {
                        Text(String(index))
                            .font(.system(size: 12, weight: .bold))
                    }
                
                Spacer()
            }
            .padding(4)
            
            Circle()
                .frame(width: 60, height: 60)
                .overlay {
                    Text(setEmoji(str: category))
                        .font(Font.system(size: 30, design: .default))
                }
                .foregroundColor(Color(red: rgb[0], green: rgb[1], blue: rgb[2], opacity: 1))
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .padding(.bottom, 12.0)
                .foregroundColor(.black)
        }
        .frame(width: 106.0, height: 140.0)
        .background(.white)
        .cornerRadius(20)
    }
}
/*
struct RewardList: Identifiable{
    let id = UUID()
    let Dday: String
    let title: String
}
*/
struct RewardCard2_Previews: PreviewProvider {
    static var previews: some View {
        RewardCard2(title: "쩌러", category: "기록없음", index: 1)
    }
}
