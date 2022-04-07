//
//  RewardCard.swift
//  donggle
//
//  Created by 윤가희 on 2022/04/07.
//

import SwiftUI

struct RewardCard: View {
    var body: some View {
        VStack(){
            Circle().frame(width: 80, height: 80)
            Text("제주도 여행")
        }
        .frame(width: 106.0, height: 140.0)
        .background(Color.gray)
        .cornerRadius(20)
    }
}

struct RewardCard_Previews: PreviewProvider {
    static var previews: some View {
        RewardCard()
    }
}
