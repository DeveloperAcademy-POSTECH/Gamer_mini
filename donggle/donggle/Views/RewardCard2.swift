
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
        VStack(){
            Text("list.Dday")
                .font(.system(size: 12, weight: .light))
                .padding(.top, 12.0)
            Spacer()
            Text("list.title")
                .font(.system(size: 14, weight: .semibold))
                .padding(.bottom, 12.0)
        }
        .frame(width: 106.0, height: 140.0)
        .background(Color.gray)
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
