
//
//  RewardCard.swift
//  donggle
//
//  Created by 윤가희 on 2022/04/07.
//

import SwiftUI

struct RewardCard2: View {
    
    //var list: RewardList
    
    var body: some View {
        VStack{
            HStack {
                Circle()
                    .frame(width: 26, height: 26)
                    .foregroundColor(Color.gray.opacity(0.2))
                
                Spacer()
            }
            .padding(4)
            
            Circle().frame(width: 60, height: 60)
                .overlay {
                    Text("🍔")
                        .font(Font.system(size: 50, design: .default))
                }
            Text("list.title")
                .font(.system(size: 14, weight: .semibold))
                .padding(.bottom, 12.0)
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
        RewardCard2()
    }
}
