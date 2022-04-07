//
//  RewardReportView.swift
//  donggle
//
//  Created by 정재윤 on 2022/04/06.
//

import SwiftUI

struct RewardCard: View {
    var name: String
    var body: some View {
        VStack {
            Text("🍔")
                .font(Font.system(size: 50, design: .default))
            Text(name)
        }.padding(20)
            .frame(height: 160)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
            .stroke(lineWidth: 1)
        )
    }
}

struct RewardReportView: View {
    var arr = ["치킨먹자", "햄버거먹자", "족발먹자", "피자먹자", "닭발먹자", "밥먹자"]
    var body: some View {
        List {
            VStack {
                Text("Top 6 스트레스 해소 보상")
                    .font(.system(size: 22, weight: .semibold))
                    .frame(maxWidth: .infinity ,alignment: .leading)
                
                ScrollView(.horizontal) {
                            HStack {
                                ForEach(arr, id: \.self) {name in
                                    RewardCard(name: name)
                                }
                            }
                            .frame(maxHeight: .infinity)
                        }
            }
            
            ProgressBar(width: 300, height: 20, percent: 69)
                .padding(.vertical, 20)
            
            ListRow(name: "인간관계")
            ListRow(name: "직장")
            ListRow(name: "수면")
            ListRow(name: "다이어트")
            ListRow(name: "그외 3개")
            
        }
    }
}

struct RewardReportView_Previews: PreviewProvider {
    static var previews: some View {
        RewardReportView()
    }
}
